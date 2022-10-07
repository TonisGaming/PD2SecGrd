local origin_init = CharacterTweakData.init
local origin_presets = CharacterTweakData._presets
local origin_charmap = CharacterTweakData.character_map

function CharacterTweakData:character_map()

	local char_map = origin_charmap(self)



	char_map.triadyacht = {
		path = "units/pd2_mod_ttr/characters/",
		list = {
			"civ_male_buyer",
			"ene_swat_gensec_1",
			"ene_swat_gensec_2",		
			"ene_city_heavy_g36",
			"ene_marshal_gensec",				
			"civ_douchebag_contractor"
		}
	}
	




	
	return char_map
end

