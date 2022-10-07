RemoteHackingInteractionExt = RemoteHackingInteractionExt or class(UseInteractionExt)
RemoteHackingInteractionExt.EVENT_IDS = {
    hack_started = 1,
	hack_success = 2,
	hack_failure = 3
}

function RemoteHackingInteractionExt:init(unit, ...)
    RemoteHackingInteractionExt.super.init(self, unit, ...)
end

function RemoteHackingInteractionExt:interact(player)
    if not self:can_interact(player) then
		return
	end

    RemoteHackingInteractionExt.super.interact(self, player)
    if not self._tweak_data.minigame_hacking then
		return
	end

    self:hack_event("hack_started", self.EVENT_IDS.hack_started, player)

    local minigame_hacking = clone(self._tweak_data.minigame_hacking)
    minigame_hacking.unit = self._unit

    game_state_machine:change_state_by_name("ingame_hacking", minigame_hacking) --{time = 20, speed = 100, segments = 3, max_segments = 13, max_attempts = 4})
end

function RemoteHackingInteractionExt:set_tweak_data(id)
	if self.tweak_data ~= id then
        self._unit:unit_data()._hacked = nil
	end

	RemoteHackingInteractionExt.super.set_tweak_data(self, id)
end

function RemoteHackingInteractionExt:hack_event(sequence, event_id, player)
    if self._unit:damage() and not self._unit:unit_data()._hacked then
        self._unit:damage():run_sequence_simple(sequence, {unit = player})
        managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "interaction", event_id)
    end
end

function RemoteHackingInteractionExt:sync_hack_event(sequence, player)
    if self._unit:damage() and not self._unit:unit_data()._hacked then
        self._unit:damage():run_sequence_simple(sequence, {unit = player})
    end
end

function RemoteHackingInteractionExt:sync_net_event(event_id, player)
    if event_id == self.EVENT_IDS.hack_started then
        self:sync_hack_event("hack_started", player)
    elseif event_id == self.EVENT_IDS.hack_success then
        self:sync_hack_event("hack_success", player)
        self._unit:unit_data()._hacked = true
    elseif event_id == self.EVENT_IDS.hack_failure then
        self:sync_hack_event("hack_failure", player)
    end
end