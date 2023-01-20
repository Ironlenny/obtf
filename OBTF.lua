Obtf = CreateFrame("Frame")
Obtf.blacklist = {"Dalaran"}
Obtf.body = "#showtooltop\n/cast [swimming] Aquatic Form; "
Obtf.outdoors_nofly = "[outdoors, noflyable]"
Obtf.outdoors = "[outdoors]"
Obtf.travelForm = "Travel Form"
Obtf.combat = "[combat]"
Obtf.swiftFlightForm = "Swift Flight Form"
Obtf.flightForm = "Flight Form"
Obtf.flyable = "[flyable, nocombat]"
Obtf:RegisterEvent("ZONE_CHANGED")

function Obtf:OnEvent()
  local delay = 1
  C_Timer.After(delay, Obtf.CheckZone)
end

function Obtf:CheckZone()
  local zone = GetSubZoneText()
  for i= 1, 1 do
    if zone == Obtf.blacklist[i] then
      Obtf:UpdateNoFlyMacro()
    else
      Obtf:UpdateFlyingMacro()
    end
  end
end

function Obtf:UpdateFlyingMacro()
  local flightForm = self.swiftFlightForm
  local body = self.body .. self.flyable .. " " .. flightForm .. "; " .. self.outdoors_nofly .. " " .. self.travelForm .. "; " .. self.combat .. " " .. self.travelForm
  self:UpdateMacro(body)
end

function Obtf:UpdateNoFlyMacro()
  local body = self.body .. self.outdoors .. " " .. self.travelForm .. "; " .. self.combat .. " " .. self.travelForm
  self:UpdateMacro(body)
end

function Obtf:UpdateMacro(body)
  macroIndex = GetMacroIndexByName("OBTF")
  if macroIndex == 0 then
    CreateMacro("OBTF", "INV_MISC_QUESTIONMARK", body, nil)
  else
    EditMacro("OBTF", "OBTF", nil, body, 1, 1)
  end
end

Obtf:SetScript("OnEvent", Obtf.OnEvent)
