Obtf = CreateFrame("Frame")
Obtf.blacklist = {"Dalaran"}
Obtf:RegisterEvent("ZONE_CHANGED")

function Obtf:CheckZone(event, ...)
  local zone = GetSubZoneText()
  for i= 0, 1 do
    if zone == self.blacklist[i] then
      Obtf:UpdateNoFlyMacro()
    else
      Obtf:UpdateFlyingMacro()
    end
  end
end

function Obtf:UpdateFlyingMacro()
  print("Can fly")
end

function Obtf:UpdateNoFlyMacro()
  print("Cannot fly")
end

Obtf:SetScript("OnEvent", Obtf.CheckZone)
