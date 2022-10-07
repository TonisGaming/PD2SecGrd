IngameHackingInteraction = IngameHackingInteraction or class(IngamePlayerBaseState)
IngameHackingInteraction.FAILED_COOLDOWN = 0.3
IngameHackingInteraction.COMPLETED_DELAY = 0.5

function IngameHackingInteraction:init(game_state_machine)
	IngameHackingInteraction.super.init(self, "ingame_hacking", game_state_machine)
end

function IngameHackingInteraction:_setup_controller()
	self._controller = managers.controller:create_controller("ingame_hacking", managers.controller:get_default_wrapper_index(), false)
	self._leave_cb = callback(self, self, "cb_leave")
	self._interact_cb = callback(self, self, "cb_interact")

	self._controller:add_trigger("primary_attack", self._interact_cb)
	self._controller:add_trigger("secondary_attack", self._leave_cb)
	self._controller:set_enabled(true)
end

function IngameHackingInteraction:_clear_controller()
	local menu_controller = managers.menu:get_controller()

	if menu_controller then
		menu_controller:enable()
	end

	if self._controller then
		self._controller:remove_trigger("primary_attack", self._interact_cb)
		self._controller:remove_trigger("secondary_attack", self._leave_cb)
		self._controller:set_enabled(false)
		self._controller:destroy()

		self._controller = nil
	end
end

function IngameHackingInteraction:update_player_stamina(t, dt)
	local player = managers.player:player_unit()

	if player and player:movement() then
		player:movement():update_stamina(t, dt, true)
	end
end

function IngameHackingInteraction:_player_damage(unit, info)
	if info.result and (info.result.type == "death" or info.result.variant and info.result.variant == "tase") then
		self:cb_leave()
	end
end

function IngameHackingInteraction:cb_leave()
	if self._completed then
		return
	end
	game_state_machine:change_state_by_name(self._old_state)
end

function IngameHackingInteraction:cb_interact()
	if self._cooldown > 0 or self._end_t or self._completed then
		return
	end

	self:_attempt_segment()
end

function IngameHackingInteraction:_attempt_segment()
	local indicator, segments = self._hud:segments()

	local success = false
    for i, segment in ipairs(segments) do
        if segment:inside(indicator:world_center()) then
			self._hud:remove_segment(i)
            success = true
            break
        end
    end

	if success then
		self:_play_sound("menu_skill_investment", true)
	else
		self:_play_sound("menu_error", true)
		self._cooldown = IngameHackingInteraction.FAILED_COOLDOWN
		self._tweak_data.attempts = self._tweak_data.attempts + 1
	end

	self._hud:hack_attempt(success)

	if self._tweak_data.attempts >= self._tweak_data.max_attempts or #segments == 0 then
		self._completed = #segments == 0
		self._end_t = IngameHackingInteraction.COMPLETED_DELAY
	end
end

function IngameHackingInteraction:update(t, dt)
	if not self._hud then
		return
	end
	self._hud:update_indicator(self._time_left, dt)
	if self._cooldown > 0 then
		self._cooldown = self._cooldown - dt

		if self._cooldown <= 0 then
			self._cooldown = 0

		end
		return
	end

	if self._end_t then
		self._end_t = self._end_t - dt

		if self._end_t <= 0 then
			self._end_t = nil
			game_state_machine:change_state_by_name(self._old_state)
		end
	elseif self._time_left > 0 then
		self._time_left = self._time_left - dt
	else
		self._end_t = IngameHackingInteraction.COMPLETED_DELAY
	end

	if alive(self._unit) and self._unit:unit_data()._hacked then
		self._completed = false
		self:cb_leave()
	end
end

function IngameHackingInteraction:at_enter(old_state, params)
	if not params then
		self:cb_leave()
		return
	end

	local player = managers.player:player_unit()
	self._unit = params.unit

	self._sound_source = self._sound_source or SoundDevice:create_source("ingame_hacking")
	self:_play_sound("sam_site_radar_loop")

	if player then
		local state = player:movement():current_state()
		local t = TimerManager:game():time()

		state:_check_stop_shooting()
		state:_interupt_action_reload(t)
		state:_interupt_action_steelsight(t)
		state:_interupt_action_running(t)
		state:_interupt_action_charging_weapon(t)
		state:_interupt_action_interact(t)
		state:_interupt_action_ladder(t)
		state:_interupt_action_melee(t)
		state:_interupt_action_throw_grenade(t)
		state:_interupt_action_throw_projectile(t)
		state:_interupt_action_use_item(t)
		state:_interupt_action_cash_inspect(t)
		state:_play_unequip_animation()

		player:base():set_enabled(false)
		player:camera()._camera_unit:base():set_limits(30, 20)
		player:camera():set_shaker_parameter("headbob", "amplitude", 0)
		player:character_damage():add_listener("IngameHackingInteraction", {
			"hurt",
			"death"
		}, callback(self, self, "_player_damage"))
		SoundDevice:set_rtpc("stamina", 100)
		self._sound_source:set_position(player:position())
	end

	params.time = params.time or 5
	params.speed = params.speed or 100
	params.segments = params.segments or 3
	params.max_segments = params.max_segments or 13
	params.max_attempts = params.max_attempts or 3
    if params.segments > params.max_segments then params.segments = params.max_segments end
	self._tweak_data = params
	self._tweak_data.attempts = 0
	self._cooldown = 0.5
	self._time_left = params.time
	self._completed = false
	self._old_state = old_state:name()

	self._hud = managers.hud:create_remote_hacking(params)

	self._hud:show()
	self:_setup_controller()

	managers.hud:show(PlayerBase.PLAYER_INFO_HUD_PD2)
	managers.hud:show(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
end

function IngameHackingInteraction:at_exit()
	self._sound_source:stop()

	local player = managers.player:player_unit()
	if self._completed then
		if alive(self._unit) then 
			self._unit:interaction():hack_event("hack_success", RemoteHackingInteractionExt.EVENT_IDS.hack_success, player)
			self._unit:unit_data()._hacked = true
		end

		self:_play_sound("camera_wrong_image_outro_end")
	else
		if alive(self._unit) then 
			self._unit:interaction():hack_event("hack_failure", RemoteHackingInteractionExt.EVENT_IDS.hack_failure, player)
		end

		self:_play_sound("sam_site_radar_interrupt")
	end

	self:_clear_controller()


	if player then
		player:base():set_enabled(true)
		player:base():set_visible(true)
		player:movement():current_state():_play_equip_animation()

		player:base().skip_update_one_frame = true
		player:camera()._camera_unit:base():remove_limits()
		player:character_damage():remove_listener("IngameHackingInteraction")
	end

	managers.hud:hide_remote_hacking(self._completed)

	self._hud = nil
	self._unit = nil

	managers.hud:show(PlayerBase.PLAYER_INFO_HUD_PD2)
	managers.hud:show(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
end

function IngameHackingInteraction:_play_sound(event, no_stop)
	if event then
		if not no_stop then
			self._sound_source:stop()
		end

		self._sound_source:post_event(event)
	end
end