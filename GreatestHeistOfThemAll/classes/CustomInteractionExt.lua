ButtButtonInteractionExt = ButtButtonInteractionExt or class(UseInteractionExt)

ButtButtonInteractionExt.PACKAGE_ID = "butt"
ButtButtonInteractionExt.PACKAGE = CustomAchievementPackage:new(ButtButtonInteractionExt.PACKAGE_ID)
ButtButtonInteractionExt.SOUND_EIGHT_ID = "butt_8"

DigitalGui.NUMBER_CLAMP = 1000000 --Dont mind me, just bandaid fixing.

function ButtButtonInteractionExt:interact(player)
	ButtButtonInteractionExt.super.interact(self, player)
	self:do_button_stuff()
	return true
end


function ButtButtonInteractionExt:sync_interacted(player)
	ButtButtonInteractionExt.super.sync_interacted(self, player)
	self:do_button_stuff()
	return true
end


function ButtButtonInteractionExt:do_button_stuff()
	if self._presses then
		self._presses = self._presses + 1
	else
		self._presses = 1
	end
	
	local achievement_id = "butt_"..tostring(self._presses)
	if ButtButtonInteractionExt.PACKAGE:HasAchievement(achievement_id) then
		ButtButtonInteractionExt.PACKAGE:Achievement(achievement_id):Unlock()
	end
	
	if self._presses == 8 then
		managers.player:local_player():sound():play(ButtButtonInteractionExt.SOUND_EIGHT_ID)
		ButtButtonInteractionExt.PACKAGE:Achievement("butt_eight"):Unlock()
	end
end

ButtPokeInteractionExt = ButtPokeInteractionExt or class(UseInteractionExt)

function ButtPokeInteractionExt:interact(player)
	ButtPokeInteractionExt.super.interact(self, player)
	self:do_button_poke()
	return true
end


function ButtPokeInteractionExt:sync_interacted(player)
	ButtPokeInteractionExt.super.sync_interacted(self, player)
	self:do_button_poke()
	return true
end


function ButtPokeInteractionExt:do_button_poke()
	if self._presses then
		self._presses = self._presses + 1
	else
		self._presses = 1
	end
	
	if self._presses <= 64 then
		local obj = self._unit:get_object(Idstring("g_poke_" .. tostring(self._presses)))
		obj:set_visibility(false)
	end
	
	local package = CustomAchievementPackage:new(ButtButtonInteractionExt.PACKAGE_ID)
	
	if self._presses == 64 then
		local achievement = package:Achievement("butt_poke")
		achievement:Unlock()
		if self._unit:damage():has_sequence("disable") then
			self._unit:damage():run_sequence_simple("disable")
		end
	end
end