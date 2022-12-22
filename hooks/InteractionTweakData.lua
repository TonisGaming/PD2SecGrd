Hooks:PostHook(InteractionTweakData, "init", "tonsecgrd_interactions", function(self, tweak_data)

	self.tonsecgrd_trykeycard = {
		text_id = "tonsecgrd_trykeycard",
		equipment_text_id = "hud_int_equipment_no_keycard",
		special_equipment = "bank_manager_key",
		action_text_id = "tonis2_ecmtest_action",
		equipment_consume = true,
		start_active = true,
		axis = "y",
		timer = 0.5
	}

	
end)