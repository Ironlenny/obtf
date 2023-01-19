Obtf = {}

Obtf.blacklist = {"Dalaran"}

function Obtf:CheckZone()
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
end

function Obtf:UpdateNoFlyMacro()
end
