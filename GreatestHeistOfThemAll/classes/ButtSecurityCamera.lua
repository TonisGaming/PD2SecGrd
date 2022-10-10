ButtSecurityCamera = ButtSecurityCamera or class()

function ButtSecurityCamera:init(unit)
	self._unit = unit
end

function ButtSecurityCamera:update(unit, t, dt)
	if managers.player and managers.player:player_unit() and managers.player:player_unit():camera() then
		local plr_ps = managers.player:player_unit():camera():position()
		self:apply_rotations(plr_ps)
	end
end

function ButtSecurityCamera:apply_rotations(target_pos)
	local camera_pos = self._unit:position()
	local look_at_pos = target_pos - camera_pos
	
	local cam_rot = Rotation()
	mrotation.set_look_at(cam_rot, look_at_pos, math.UP)
	

	local yaw_obj = self._yaw_obj or self._unit:get_object(Idstring("CameraYaw"))
	local original_yaw_rot = yaw_obj:local_rotation()
	local new_yaw_rot = Rotation(180 + cam_rot:yaw(), original_yaw_rot:pitch(), original_yaw_rot:roll())
	yaw_obj:set_local_rotation(new_yaw_rot)


	local pitch_obj = self._pitch_obj or self._unit:get_object(Idstring("CameraPitch"))
	local original_pitch_rot = pitch_obj:local_rotation()
	local new_pitch_rot = Rotation(original_pitch_rot:yaw(), cam_rot:pitch(), original_pitch_rot:roll())
	pitch_obj:set_local_rotation(new_pitch_rot)
end