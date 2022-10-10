ButtClockExt = ButtClockExt or class()

ButtClockExt.PACKAGE_ID = "butt"
ButtClockExt.HAND_H = "a_hour"
ButtClockExt.HAND_M = "a_minute"
ButtClockExt.HAND_S = "a_second"

function ButtClockExt:init(unit)
	self._unit = unit
	self._hand_h = unit:get_object(Idstring(ButtClockExt.HAND_H))
	self._hand_m = unit:get_object(Idstring(ButtClockExt.HAND_M))
	self._hand_s = unit:get_object(Idstring(ButtClockExt.HAND_S))
	self._update_wait = 1
	self:set_hands()
end

function ButtClockExt:update(unit, t, dt)
	if t >= self._update_wait then
		self._update_wait = t + 1
		self:set_hands()
	end
end

function ButtClockExt:set_hands()
	local secs = tonumber(Application:date("%S")) / 60
	local mins = tonumber(Application:date("%M")) / 60
	local hour = tonumber(Application:date("%H"))
	
	local is_bedtime = (hour <= 3)
	if is_bedtime then
		local package = CustomAchievementPackage:new(ButtClockExt.PACKAGE_ID)
		package:Achievement("butt_clock"):Unlock()
	end
	
	hour = hour / 12
	
	self._hand_s:set_local_rotation(
		Rotation(
			0,
			0,
			secs * 360
		)
	)
	
	self._hand_m:set_local_rotation(
		Rotation(
			0,
			0,
			mins * 360
		)
	)
	
	self._hand_h:set_local_rotation(
		Rotation(
			0,
			0,
			hour * 360
		)
	)
	self._unit:set_moving()--updates graphics
end