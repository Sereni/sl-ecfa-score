-- Calculates and displays score for ECFA19
function GetFaScore(pn)
  local fantastics = tonumber(SCREENMAN:GetTopScreen():GetChild('MarvelousNumberP' .. pn+1):GetText())
  local misses = tonumber(SCREENMAN:GetTopScreen():GetChild('MissNumberP' .. pn+1):GetText())
  local mineStats = SCREENMAN:GetTopScreen():GetChild('MinesTextP' .. pn+1):GetText()
  local minesDodged, minesTotal = GetValues(mineStats)
  local minesHit = minesTotal - minesDodged
  local holdStats = SCREENMAN:GetTopScreen():GetChild('HoldsTextP' .. pn+1):GetText()
  local holdsHeld, holdsTotal = GetValues(holdStats)
  local holdsDropped = holdsTotal - holdsHeld
  local rollStats = SCREENMAN:GetTopScreen():GetChild('RollsTextP' .. pn+1):GetText()
  local rollsRolled, rollsTotal = GetValues(rollStats)
  local rollsDropped = rollsTotal - rollsRolled
  return fantastics - 0.5 * (misses + minesHit + holdsDropped + rollsDropped)
end

function GetValues(str)
  local t = {}
  local i = 1
  for char in string.gfind(str,"%d+") do
    t[i] = char
    i=i+1
  end
  return tonumber(t[1]),tonumber(t[2])
end

function GetStaminaFaScore(pn)
  local fantastics=SCREENMAN:GetTopScreen():GetChild('MarvelousNumberP' .. pn+1):GetText()
  return fantastics
end

function IsStaminaFA()
  local t = {}
  local i = 1
  for sDir in string.gfind(GAMESTATE:GetCurrentSong():GetSongDir(),"/Songs/([^/]+)/") do
    t[i]=sDir
    i=i+1
  end
  return t[1] == "ECFA 2019 - Stamina FA"
end

function IsEcfaPack()
  local t = {}
  local i = 1
  for sDir in string.gfind(GAMESTATE:GetCurrentSong():GetSongDir(),"/Songs/([^/]+)/") do
    t[i]=sDir
    i=i+1
  end
  return 
    t[1] == "ECFA 2019 - Lower" or
    t[1] == "ECFA 2019 - Middle" or
    t[1] == "ECFA 2019 - Upper"
end

-- Returns the score and name of the function used to calculate it
function GetScoreAndLabel(pn)
  if IsStaminaFA() then
    return GetStaminaFaScore(pn), "Stamina FA"
  elseif IsEcfaPack() then
    return GetFaScore(pn), "FA"
  else
    return "", ""
  end
end


