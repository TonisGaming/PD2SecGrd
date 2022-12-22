Hooks:PostHook(GroupAITweakData, "_init_enemy_spawn_groups", "more_fucking_marshal", function(self, difficulty_index)
	if Global.level_data and Global.level_data.level_id == "trai" or Global.game_settings and Global.game_settings.level_id == "trai" then
		self.enemy_spawn_groups.marshal_squad = {
			spawn_cooldown = 0,
			max_nr_simultaneous_groups = 2,
			initial_spawn_delay = 0,
			amount = {
				2,
				2
			},
			spawn = {
				{
					respawn_cooldown = 0,
					amount_min = 1,
					rank = 2,
					freq = 1,
					unit = "marshal_shield",
					tactics = self._tactics.marshal_shield
				},
				{
					respawn_cooldown = 0,
					amount_min = 1,
					rank = 1,
					freq = 1,
					unit = "marshal_marksman",
					tactics = self._tactics.marshal_marksman
				}
			},
			spawn_point_chk_ref = table.list_to_set({
				"tac_shield_wall",
				"tac_shield_wall_ranged",
				"tac_shield_wall_charge"
			})
		}
	else
		self.enemy_spawn_groups.marshal_squad = {
			spawn_cooldown = 0,
			max_nr_simultaneous_groups = 3,
			amount = {
				2,
				2
			},
			spawn = {
				{
					respawn_cooldown = 0,
					amount_max = 1,
					rank = 1,
					freq = 1,
					unit = "marshal_marksman",
					tactics = self._tactics.marshal_marksman
				}
			},
			spawn_point_chk_ref = table.list_to_set({
				"tac_swat_rifle_flank",
				"tac_swat_rifle"
			})
		}
	end
end)