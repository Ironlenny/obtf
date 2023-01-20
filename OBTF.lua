Obtf = CreateFrame("Frame")
Obtf.blacklist = {"Dalaran"}
Obtf.outdoors_nofly = "[outdoors, noflyable]"
Obtf.outdoors = "[outdoors]"
Obtf.swimming = "[swimming]"
Obtf.aquaticForm = "Aquatic Form"
Obtf.travelForm = "Travel Form"
Obtf.combat = "[combat]"
Obtf.swiftFlightForm = "Swift Flight Form"
Obtf.flightForm = "Flight Form"
Obtf.flyable = "[flyable, nocombat]"
Obtf:RegisterEvent("ZONE_CHANGED")
Obtf:RegisterEvent("PLAYER_ENTERING_WORLD")
Obtf.forms = {}
Obtf.forms[Obtf.swiftFlightForm] = 40120
Obtf.forms[Obtf.flightForm] = 33943
Obtf.forms[Obtf.travelForm] = 783
Obtf.forms[Obtf.aquaticForm] = 1066
Obtf.noFlyMacro = ""
Obtf.flyMacro = ""

-- Initialize the macro strings. Check which forms are available
function Obtf:Init()
  local start = "#showtooltop\n/cast "
  local noFlyMacro = start
  local flyMacro = start

  if IsSpellKnown(self.forms[self.aquaticForm]) then
    noFlyMacro = noFlyMacro .. self.swimming .. " " .. self.aquaticForm .. "; "
    flyMacro = flyMacro .. self.swimming .. " " .. self.aquaticForm .. "; "
  end

  if IsSpellKnown(self.forms[self.travelForm]) then
    noFlyMacro = noFlyMacro .. self.combat .. " " .. self.travelForm .. "; " .. self.outdoors .. " " .. self.travelForm
    flyMacro = flyMacro .. self.combat .. " " .. self.travelForm .. "; " .. self.outdoors_nofly .. " " .. self.travelForm .. "; "
  end

  if IsSpellKnown(self.forms[self.flightForm]) then
    flyMacro = flyMacro .. self.flyable .. " " .. self.flightForm
  elseif IsSpellKnown(self.forms[self.swiftFlightForm]) then
    flyMacro = flyMacro .. self.flyable .. " " .. self.swiftFlightForm
  end

  self.noFlyMacro = noFlyMacro
  self.flyMacro = flyMacro
end

-- Event handler
function Obtf:OnEvent(event, isLogin, isReload)
  local delay = 1
  if isLogin or isReload then
    Obtf:Init() -- Must use Obtf instead of self, as self is not passed into callbacks.
  else
    C_Timer.After(delay, Obtf.CheckZone)
  end
end

-- Check what's the player's subzone and call the approriate macro update function.
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
  self:UpdateMacro(self.flyMacro)
end

function Obtf:UpdateNoFlyMacro()
  self:UpdateMacro(self.noFlyMacro)
end

-- Updates the macro with the passed in body
function Obtf:UpdateMacro(body)
  macroIndex = GetMacroIndexByName("OBTF")
  if macroIndex == 0 then
    CreateMacro("OBTF", "INV_MISC_QUESTIONMARK", body, nil)
  else
    EditMacro("OBTF", "OBTF", nil, body, 1, 1)
  end
end

Obtf:SetScript("OnEvent", Obtf.OnEvent)
