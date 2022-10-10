
Hooks:PostHook(HUDAssaultCorner,"show_casing","butt_show_casing",function(self, mode)
	
	local delay_time = self._assault and 1.2 or 0
	local casing_panel = self._hud_panel:child("casing_panel")
	local text_panel = casing_panel:child("text_panel")
	text_panel:script().text_list = {}
	self._casing_bg_box:script().text_list = {}
	
	--
	local msg = {}
	local _m_end = "hud_assault_end_line"
	local _m_clean = "hud_casing_mode_ticker_clean_butt"
	local _m_prefix = "hud_butt_mode_ticker_"
	local total_memes = 21
	
	for i = 1, 100 do
		local roll = math.rand(1)
		if roll < 0.95 then
			table.insert(msg, _m_clean)
		else
			
			table.insert(msg, _m_prefix..tostring(math.round(math.random(1, total_memes))))
		end
		table.insert(msg, _m_end)
	end
	--
	
	
	for _, text_id in ipairs(msg) do
		table.insert(text_panel:script().text_list, text_id)
		table.insert(self._casing_bg_box:script().text_list, text_id)
	end

	if self._casing_bg_box:child("text_panel") then
		self._casing_bg_box:child("text_panel"):stop()
		self._casing_bg_box:child("text_panel"):clear()
	else
		self._casing_bg_box:panel({
			halign = "grow",
			name = "text_panel"
		})
	end

	self._casing_bg_box:child("bg"):stop()
	self:_hide_hostages()
	casing_panel:stop()
	casing_panel:animate(callback(self, self, "_animate_show_casing"), delay_time)
end)