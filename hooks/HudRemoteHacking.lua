function HUDManager:create_remote_hacking(params)
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
	self._hud_remote_hacking = self._hud_remote_hacking or HUDRemoteHacking:new(hud, params)

	self._hud_remote_hacking:set_tweak_data(params)

	return self._hud_remote_hacking
end

function HUDManager:show_remote_hacking()
	if self._hud_remote_hacking then
		self._hud_remote_hacking:show()
	end
end

function HUDManager:hide_remote_hacking(completed)
	if self._hud_remote_hacking then
		self._hud_remote_hacking:hide(completed)
	end
end

HUDRemoteHacking = HUDRemoteHacking or class()

function HUDRemoteHacking:init(hud, params)
    self._hud_panel = hud.panel
    if self._hud_panel:child("remote_hacking_panel") then
        self._hud_panel:remove(self._hud_panel:child("remote_hacking_panel"))
    end

    self._panel = self._hud_panel:panel({
        name = "remote_hacking_panel", 
        layer = 100, 
        visible = false,
        w = 300,
        h = 125
    })
    self._panel:set_center_x(self._hud_panel:w() / 2)
    self._panel:set_center_y(self._hud_panel:h() / 1.5)

    local hacking_panel = self._panel:panel({
        name = "hacking_panel", 
        w = 280,
        h = 117,
        visible = false
    })
    hacking_panel:set_center(self._panel:w() / 2, self._panel:h() / 2)

    local hack_title = hacking_panel:text({
		name = "hack_title",
		align = "left",
		text = managers.localization:to_upper_text("hud_remote_hack_title"),
		layer = 2,
		color = Color.white,
		font_size = tweak_data.hud.active_objective_title_font_size,
		font = tweak_data.hud.medium_font_noshadow
	})
    managers.hud:make_fine_text(hack_title)

    self._time_left = hacking_panel:text({
		name = "time_left",
		align = "right",
		text = "00:00",
		layer = 2,
		color = Color.white,
		font_size = tweak_data.hud.active_objective_title_font_size,
		font = tweak_data.hud.medium_font_noshadow
	})

    local hack_text = hacking_panel:text({
		name = "hack_text",
		text = managers.localization:to_upper_text("hud_remote_hack_attempt", {
            BTN_PRIMARY = managers.localization:btn_macro("primary_attack", true)
        }),
		layer = 2,
		color = Color.white,
		font_size = tweak_data.menu.pd2_small_font_size,
		font = tweak_data.menu.pd2_medium_font,
	})
    managers.hud:make_fine_text(hack_text)
    hack_text:set_bottom(hacking_panel:h())

    local cancel_text = hacking_panel:text({
		name = "hack_text",
		text = managers.localization:to_upper_text("hud_remote_hack_cancel", {
            BTN_SECONDARY = managers.localization:btn_macro("secondary_attack", true)
        }),
		layer = 2,
		color = Color.white,
		font_size = tweak_data.menu.pd2_small_font_size,
		font = tweak_data.menu.pd2_medium_font,
	})
    managers.hud:make_fine_text(cancel_text)
    cancel_text:set_right(hacking_panel:w())
    cancel_text:set_bottom(hacking_panel:h())

    self._attempts_panel = hacking_panel:panel({
        name = "attempts_panel", 
        y = -5,
        w = 0,
        h = hack_title:h()
    })

    self._bg_box = HUDBGBox_create(self._panel)

    self._segment_panel = self._bg_box:panel({
        name = "segment_panel", 
        y = 35,
        w = 280,
        h = 60,
    })
    self._segment_panel:set_center_x(self._bg_box:w() / 2)

end

function HUDRemoteHacking:update_indicator(time_left, dt)
    local t = self._tweak_data.time - time_left
    local p = math.sin(t * self._tweak_data.speed) / 2 + 0.5

    self._indicator:set_center_x(math.lerp(0, self._segment_panel:w(), p))

    local time = math.floor(math.max(0, time_left * 100))
    local seconds = math.floor(time / 100)
    time = time - seconds * 100
	local nano = math.round(time)

    local text = (seconds < 10 and "0" .. seconds or seconds) .. ":" .. (nano < 10 and "0" .. nano or nano)
    self._time_left:set_text(text)

    if not self._segment_update_t or self._segment_update_t <= 0 then
        for i, segment in pairs(self._segments) do
            local segment_w = segment:texture_width() / 5
            local offset = math.random(segment_w, segment_w * 6)
            segment:set_texture_coordinates(Vector3(0 + offset, 0, 0), Vector3(segment_w - offset, 0, 0), Vector3(0 + offset, 16, 0), Vector3(segment_w - offset, 16, 0))
        end
        self._segment_update_t = 0.1
    else
        self._segment_update_t = self._segment_update_t - dt
    end

    local item_width = self._connector:w()
    self._connector_fw = (self._connector_fw + dt * 20) % self._connector:texture_width()
    self._connector:set_texture_coordinates(Vector3(0 + self._connector_fw, 0, 0), Vector3(item_width + self._connector_fw, 0, 0), Vector3(0 + self._connector_fw, 16, 0), Vector3(item_width + self._connector_fw, 16, 0))
end

function HUDRemoteHacking:create_segments()
    self._segment_panel:clear()
    local bg = self._segment_panel:rect({
        name = "bg",
        color = Color.black,
        alpha = 0.5,
    })

    local fill = self._segment_panel:bitmap({
		layer = 1,
		name = "fill",
		texture_rect = {
			0,
			0,
			512,
			256
		},
        alpha = 0.8,
        texture ="guis/textures/pd2/skilltree_2/subtree_fill",
		w = self._segment_panel:w(),
		h = self._segment_panel:h() * 2
	})
    self._connector = self._segment_panel:bitmap({
        blend_mode = "add",
        texture = "guis/dlcs/infamous/textures/pd2/infamous_tree/connector_df",
        h = 26,
        alpha = 0.8,
        layer = 3,
        wrap_mode = "wrap",
        w = self._segment_panel:w()
    })
    self._connector:set_center_y(self._segment_panel:h() / 2)
    self._connector_fw = 0

    local image_scanlines = self._segment_panel:bitmap({
		name = "image_scanlines",
		texture = "guis/dlcs/chill/textures/pd2/rooms/safehouse_room_preview_effect",
        texture_rect = {
			0,
			0,
			512,
			512
		},
		wrap_mode = "wrap",
		layer = 50,
		w = self._segment_panel:w(),
		h = self._segment_panel:h() * 7,
		y = self._segment_panel:h() * 2 * -1
	})
    local outline = self._segment_panel:rect({
		h = 2,
        layer = 10,
        color = Color(0.5, 0, 6.31, 6.94)
	})
    outline:set_bottom(self._segment_panel:h())

    self._indicator = self._segment_panel:bitmap({
        name = "indicator", 
        texture = "guis/textures/pd2/shared_lines",
        layer = 6, 
        w = 2,
        h = 50
    })
    self._indicator:set_center(self._segment_panel:w() / 2, self._segment_panel:h() / 2)

    local tries = 0
    local max_tries = 10
    self._segments = {}
    local segment_w = self._segment_panel:w() / self._tweak_data.max_segments

    local usable_segments = {}
    local segment_id = {}
    for i = 1, self._tweak_data.max_segments do
        table.insert(usable_segments, i)
        local rand = math.random(#usable_segments)
    end

    while #segment_id < self._tweak_data.segments do
        local rand = math.random(1, #usable_segments)
        local slot = usable_segments[rand]
        if not slot then 
            break 
        end
        local valid = not table.contains(segment_id, slot)
        valid = valid and not table.contains(segment_id, slot + 1)
        valid = valid and not table.contains(segment_id, slot - 1)

        if valid or tries >= max_tries then
            local segment = self._segment_panel:bitmap({
                name = "segment_"..slot,
                texture = "guis/textures/pd2/hacking_segment_df",
                x = segment_w * (slot-1),
                w = segment_w,
                wrap_mode = "wrap",
                blend_mode = "add",
                color = tweak_data.screen_colors.crime_spree_risk,
                h = 80,
                layer = 15
            })
            segment:set_center_y(self._segment_panel:h() / 2)
            tries = 0
            table.insert(segment_id, slot)
            table.insert(self._segments, segment)
            table.delete(usable_segments, slot)
        else
            tries = tries + 1
        end
    end
end

function HUDRemoteHacking:segments()
    return self._indicator, self._segments
end

function HUDRemoteHacking:remove_segment(i)
    local segment = self._segments[i]
    table.remove(self._segments, i)
    segment:animate(callback(self, self, "animate_segment_hacked"))
end

function HUDRemoteHacking:hack_attempt(success)
    local bg = self._segment_panel:child("bg")
    bg:stop()
    bg:animate(callback(self, self, "animate_hack_attempt"), success and tweak_data.screen_colors.stats_positive or tweak_data.screen_colors.stats_negative)

    for i = 1, self._tweak_data.attempts, 1 do
        local attempt = self._attempts_panel:child("attempt_".. i)
        if attempt then
            attempt:set_color(tweak_data.screen_colors.one_down)
        end
    end
end
function HUDRemoteHacking:show()
    self._active = true
    math.randomseed(os.time())
    self._panel:set_visible(true)
    local function open_done()
		self._panel:child("hacking_panel"):set_visible(true)
	end

    self._bg_box:stop()
    self._bg_box:animate(callback(nil, _G, "HUDBGBox_animate_open_center"), nil, self._panel:w(), open_done, {attention_color = Color.black})

    self:create_segments()

    local attempts = self._tweak_data.max_attempts or 3
    local x = 0
    local panel_w = 0
    local texture, rect = tweak_data.hud_icons:get_icon_data("risk_death_squad")
    self._attempts_panel:clear()
    for i = 1, attempts do
        local attemp = self._attempts_panel:bitmap({
            name = "attempt_".. i,
			y = 3,
			x = 0,
			texture = texture,
			texture_rect = rect,
			alpha = 1,
			color = tweak_data.screen_colors.achievement_grey,
			w = self._attempts_panel:h(),
			h = self._attempts_panel:h()
		})

		attemp:set_x(x)
        x = x + attemp:w()
        panel_w = math.max(panel_w, attemp:right())
    end
    self._attempts_panel:set_w(panel_w)
    self._attempts_panel:set_center_x(self._attempts_panel:parent():w() / 2)

    local hacking_panel = self._panel:child("hacking_panel")
    local hack_title = hacking_panel:child("hack_title")

    managers.hud:make_fine_text(hack_title)
end

function HUDRemoteHacking:hide(completed)
    self._active = false

    local function close_done()
		self._panel:set_visible(false)
	end
    self._bg_box:stop()
    self._bg_box:animate(callback(nil, _G, "HUDBGBox_animate_close_center"), close_done)
    self._panel:child("hacking_panel"):set_visible(false)
end

function HUDRemoteHacking:set_tweak_data(data)
    self._tweak_data = data
end

function HUDRemoteHacking:animate_hack_attempt(panel, color)
    local TOTAL_T = IngameHackingInteraction.FAILED_COOLDOWN
	local t = TOTAL_T

	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt

        local c = math.lerp(color, Color.black, 1 - t / TOTAL_T)
		panel:set_color(c)
	end
    panel:set_color(Color.black)
end

function HUDRemoteHacking:animate_segment_hacked(panel)
    local TOTAL_T = IngameHackingInteraction.FAILED_COOLDOWN
	local t = TOTAL_T

    local center_x, center_y = panel:center()
    local w, h = panel:size()
    panel:set_rotation(360)
    panel:set_color(tweak_data.screen_colors.stats_positive)
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
        local p = t / TOTAL_T

        panel:set_w(math.lerp(w, 0, 1 - t / TOTAL_T))
        panel:set_h(math.lerp(h, 0, 1 - t / TOTAL_T))
        panel:set_alpha(p)

        panel:set_center(center_x, center_y)
	end

    self._segment_panel:remove(panel)
end