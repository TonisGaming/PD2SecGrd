Hooks:PostHook(GamemodeStandard,"setup_gsm","warzone_states", function(self, gsm, empty, setup_boot, setup_title)
    Gamemode.STATES.ingame_hacking = "ingame_hacking"
    local ingame_hacking = IngameHackingInteraction:new(gsm)
    local ingame_hacking_func = callback(nil, ingame_hacking, "default_transition")

    local editor = gsm._states["editor"]
    local world_camera = gsm._states["world_camera"]
    local ingame_standard = gsm._states["ingame_standard"]
    local ingame_mask_off = gsm._states["ingame_mask_off"]
    local ingame_bleed_out = gsm._states["ingame_bleed_out"]
    local ingame_arrested = gsm._states["ingame_arrested"]
    local ingame_fatal = gsm._states["ingame_fatal"]
    local ingame_incapacitated = gsm._states["ingame_incapacitated"]
    local ingame_waiting_for_players = gsm._states["ingame_waiting_for_players"]
    local ingame_clean = gsm._states["ingame_clean"]
    local ingame_civilian = gsm._states["ingame_civilian"]
    local ingame_driving = gsm._states["ingame_driving"]
    local ingame_parachuting = gsm._states["ingame_parachuting"]
    local ingame_freefall = gsm._states["ingame_freefall"]
    local server_left = gsm._states["server_left"]
    local victoryscreen = gsm._states["victoryscreen"]
    local disconnected = gsm._states["disconnected"]
    local kicked = gsm._states["kicked"]

    local empty_func = callback(nil, empty, "default_transition")
	local editor_func = callback(nil, editor, "default_transition")
	local world_camera_func = callback(nil, world_camera, "default_transition")
	local ingame_standard_func = callback(nil, ingame_standard, "default_transition")
	local ingame_mask_off_func = callback(nil, ingame_mask_off, "default_transition")
	local ingame_bleed_out_func = callback(nil, ingame_bleed_out, "default_transition")
	local ingame_arrested_func = callback(nil, ingame_arrested, "default_transition")
	local ingame_fatal_func = callback(nil, ingame_fatal, "default_transition")
	local ingame_incapacitated_func = callback(nil, ingame_incapacitated, "default_transition")
	local ingame_waiting_for_players_func = callback(nil, ingame_waiting_for_players, "default_transition")
	local ingame_clean_func = callback(nil, ingame_clean, "default_transition")
	local ingame_civilian_func = callback(nil, ingame_civilian, "default_transition")
	local ingame_driving_func = callback(nil, ingame_driving, "default_transition")
	local ingame_parachuting_func = callback(nil, ingame_parachuting, "default_transition")
    local ingame_freefall_func = callback(nil, ingame_freefall, "default_transition")
    
    gsm:add_transition(world_camera, ingame_hacking, world_camera_func)
    gsm:add_transition(ingame_standard, ingame_hacking, ingame_standard_func)
    gsm:add_transition(empty, ingame_hacking, empty_func)

    gsm:add_transition(ingame_hacking, editor, ingame_hacking_func)
	gsm:add_transition(ingame_hacking, world_camera, ingame_hacking_func)
	gsm:add_transition(ingame_hacking, ingame_mask_off, ingame_hacking_func)
	gsm:add_transition(ingame_hacking, ingame_standard, ingame_hacking_func)
	gsm:add_transition(ingame_hacking, ingame_bleed_out, ingame_hacking_func)
	gsm:add_transition(ingame_hacking, ingame_parachuting, ingame_hacking_func)
	gsm:add_transition(ingame_hacking, ingame_fatal, ingame_hacking_func)
	gsm:add_transition(ingame_hacking, server_left, ingame_hacking_func)
	gsm:add_transition(ingame_hacking, victoryscreen, ingame_hacking_func)
	gsm:add_transition(ingame_hacking, disconnected, ingame_hacking_func)
	gsm:add_transition(ingame_hacking, kicked, ingame_hacking_func)
    gsm:add_transition(ingame_hacking, ingame_waiting_for_players, ingame_hacking_func)
    gsm:add_transition(ingame_hacking, ingame_freefall, ingame_hacking_func)
end)