return function(instigator, mod)
	local u_name = tostring(managers.network.account:username())
	u_name = string.upper(u_name)
	if string.match(u_name, "OVERKILL_") then
		local package = CustomAchievementPackage:new("butt")
		package:Achievement("butt_dev"):Unlock()
	end
end