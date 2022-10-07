
if not Global.level_data then return end

Hooks:PostHook(GroupAITweakData, "_init_unit_categories", "america_groupai", function(self, difficulty_index)
	
	self.unit_categories.CS_cop_C45_R870.unit_types.america = {
		Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_1/ene_swat_gensec_1"),
		Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_2/ene_swat_gensec_2"),
		Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_1/ene_swat_gensec_1")
	}
	
	self.unit_categories.CS_cop_stealth_MP5.unit_types.america = {Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_1/ene_swat_gensec_1")}
	
	self.unit_categories.CS_swat_MP5.unit_types.america =	{
	Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_1/ene_swat_gensec_1"),
	Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_2/ene_swat_gensec_2")
	}
	self.unit_categories.CS_swat_R870.unit_types.america =	{
	Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_1/ene_swat_gensec_1"),
	Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_2/ene_swat_gensec_2")
	}
	
	self.unit_categories.CS_heavy_M4.unit_types.america =	{
	Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_heavy_1/ene_swat_gensec_heavy_1"),
	Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_heavy_2/ene_swat_gensec_heavy_2")
	}
	self.unit_categories.CS_heavy_R870.unit_types.america =	{
	Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_heavy_1/ene_swat_gensec_heavy_1"),
	Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_heavy_2/ene_swat_gensec_heavy_2")
	}
	
	self.unit_categories.CS_shield.unit_types.america =		{Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_shield/ene_swat_gensec_shield")}
	
	self.unit_categories.FBI_suit_C45_M4.unit_types.america = {
		Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_1/ene_swat_gensec_1"),
		Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_2/ene_swat_gensec_2"),
		Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_2/ene_swat_gensec_2")
	}
	self.unit_categories.FBI_suit_M4_MP5.unit_types.america = {
		Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_2/ene_swat_gensec_2"),
		Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_1/ene_swat_gensec_1"),
	}
	self.unit_categories.FBI_suit_stealth_MP5.unit_types.america = {Idstring("units/pd2_mod_ttr/characters/ene_swat_gensec_heavy_1/ene_swat_gensec_heavy_1")}
	
	self.unit_categories.marshal_marksman.unit_types.america = {Idstring("units/pd2_mod_ttr/characters/ene_marshal_gensec/ene_marshal_gensec")}	
	if difficulty_index < 6 then
		-- FBI
		self.unit_categories.FBI_swat_M4.unit_types.america =	{
		Idstring("units/pd2_mod_ttr/characters/ene_fbi_gensec_1/ene_fbi_gensec_1"),
		Idstring("units/pd2_mod_ttr/characters/ene_fbi_gensec_2/ene_fbi_gensec_2")
		}
		self.unit_categories.FBI_swat_R870.unit_types.america =	{
		Idstring("units/pd2_mod_ttr/characters/ene_fbi_gensec_1/ene_fbi_gensec_1"),
		Idstring("units/pd2_mod_ttr/characters/ene_fbi_gensec_2/ene_fbi_gensec_2")
		}
		
		self.unit_categories.FBI_heavy_G36.unit_types.america =	{
		Idstring("units/pd2_mod_ttr/characters/ene_fbi_gensec_heavy/ene_fbi_gensec_heavy"),
		Idstring("units/pd2_mod_ttr/characters/ene_fbi_gensec_heavy_r870/ene_fbi_gensec_heavy_r870")
		}
		self.unit_categories.FBI_heavy_R870.unit_types.america =	{
		Idstring("units/pd2_mod_ttr/characters/ene_fbi_gensec_heavy/ene_fbi_gensec_heavy"),
		Idstring("units/pd2_mod_ttr/characters/ene_fbi_gensec_heavy_r870/ene_fbi_gensec_heavy_r870")
		}
		
		self.unit_categories.FBI_shield.unit_types.america = {Idstring("units/pd2_mod_ttr/characters/ene_fbi_gensec_shield/ene_fbi_gensec_shield")}
		
	elseif difficulty_index < 8 then
		-- City
		self.unit_categories.FBI_swat_M4.unit_types.america =	{
		Idstring("units/pd2_mod_ttr/characters/ene_city_swat_1/ene_city_swat_1"),
		Idstring("units/pd2_mod_ttr/characters/ene_city_swat_2/ene_city_swat_2")		
		}
		
		self.unit_categories.FBI_swat_R870.unit_types.america =	{
		Idstring("units/pd2_mod_ttr/characters/ene_city_swat_1/ene_city_swat_1"),
		Idstring("units/pd2_mod_ttr/characters/ene_city_swat_2/ene_city_swat_2")		
		}
		
		self.unit_categories.FBI_heavy_G36.unit_types.america =	{
		Idstring("units/pd2_mod_ttr/characters/ene_city_heavy_g36/ene_city_heavy_g36"),
		Idstring("units/pd2_mod_ttr/characters/ene_city_heavy_r870/ene_city_heavy_r870")
		}
		self.unit_categories.FBI_heavy_R870.unit_types.america =	{
		Idstring("units/pd2_mod_ttr/characters/ene_city_heavy_g36/ene_city_heavy_g36"),
		Idstring("units/pd2_mod_ttr/characters/ene_city_heavy_r870/ene_city_heavy_r870")
		}
		
		self.unit_categories.FBI_shield.unit_types.america = {Idstring("units/pd2_mod_ttr/characters/ene_fbi_gensec_shield/ene_fbi_gensec_shield")}
		
	else
		-- ZEALs
		self.unit_categories.FBI_swat_M4.unit_types.america =	{Idstring("units/pd2_mod_ttr/characters/ene_zeal_gensec_1/ene_zeal_gensec_1")}
		self.unit_categories.FBI_swat_R870.unit_types.america =	{Idstring("units/pd2_mod_ttr/characters/ene_zeal_gensec_1/ene_zeal_gensec_1")}
		
		self.unit_categories.FBI_heavy_G36.unit_types.america =	{Idstring("units/pd2_mod_ttr/characters/ene_zeal_gensec_heavy_1/ene_zeal_gensec_heavy_1")}
		self.unit_categories.FBI_heavy_R870.unit_types.america =	{Idstring("units/pd2_mod_ttr/characters/ene_zeal_gensec_heavy_1/ene_zeal_gensec_heavy_1")}
		
		self.unit_categories.FBI_shield.unit_types.america = {Idstring("units/pd2_mod_ttr/characters/ene_fbi_gensec_shield/ene_fbi_gensec_shield")}
	end
end)
