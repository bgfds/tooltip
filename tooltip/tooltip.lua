local GameTooltip = GameTooltip
local orig = {}

	GameTooltip:SetBackdrop({bgFile = [[Interface\AddOns\tooltip\background]], 
                                            --edgeFile = [[Interface\AddOns\tooltip\border]], 
                                            --tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 5, right = 5, top = 4, bottom = 4 }});
												
	



    GameTooltipStatusBar:ClearAllPoints()
    GameTooltipStatusBar:SetPoint('LEFT', GameTooltipStatusBar:GetParent(), 5, 0)
    GameTooltipStatusBar:SetPoint('RIGHT', GameTooltipStatusBar:GetParent(), -5, 0)
    GameTooltipStatusBar:SetPoint('TOP', GameTooltipStatusBar:GetParent(), 'BOTTOM', 0, 3)
	
	
	
	function GameTooltip_SetDefaultAnchor(tooltip, parent)   
		tooltip:SetOwner(parent, "ANCHOR_NONE");
		tooltip:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", 180, 180);
		tooltip.default = 1;
	end
	
    local f = CreateFrame'Frame'    -- 
    f:RegisterEvent'UPDATE_MOUSEOVER_UNIT'
    f:SetScript('OnEvent', function()
        local g = GetGuildInfo'mouseover'
        local n = GameTooltipTextLeft2:GetText()
        local c = UnitClassification'mouseover'
        if g then GameTooltip:AddLine('<'..g..'>', 0, 1, 0) end
        if string.find(n, 'Level (.+)') and c ~= 'normal' and c ~= 'minus' then
            local t = gsub(n, 'Level (.+) ((.+))', '%1')
            local classification = c == 'elite' and '(Elite)' or c == 'rare' and '(Rare)' or c == 'rareelite' and '(Rare Elite)' or '(Boss)'
            GameTooltipTextLeft2:SetText('Level '..t..' '..classification)
        end
        if GameTooltipStatusBar:IsShown() and GameTooltipStatusBar:GetValue() > 0
        and (not string.find(GameTooltip:GetParent():GetName(), 'PlayerFrame')
         or  not string.find(GameTooltip:GetParent():GetName(), 'TargetFrame')
         or  not string.find(GameTooltip:GetParent():GetName(), 'PartyFrame')
         or  not string.find(GameTooltip:GetParent():GetName(), 'RaidFrame')) then
        else
            GameTooltipStatusBar:Hide()
        end
        GameTooltip:Show()
    end)