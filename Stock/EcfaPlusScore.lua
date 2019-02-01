-- Calculates and displays score for ECFA19
function GetValues(str)
  local t = {}
  local i = 1
  for char in string.gfind(str,"%d+") do
    t[i] = char
    i=i+1
  end
  return tonumber(t[1]),tonumber(t[2])
end

function isEmpty(str)
  return str == nil or str == ''
end

function GetFaPlusScore(pn)
  -- FA+ score is a % of blue fantastics.
  local blue = tonumber(SCREENMAN:GetTopScreen():GetChild('MarvelousNumberP' .. pn+1):GetText())
  local white = tonumber(SCREENMAN:GetTopScreen():GetChild('PerfectNumberP' .. pn+1):GetText())
  local excellent = tonumber(SCREENMAN:GetTopScreen():GetChild('GreatNumberP' .. pn+1):GetText())
  local great = tonumber(SCREENMAN:GetTopScreen():GetChild('GoodNumberP' .. pn+1):GetText())
  local decent = tonumber(SCREENMAN:GetTopScreen():GetChild('BooNumberP' .. pn+1):GetText())
  if isEmpty(great) then great=0 end
  if isEmpty(decent) then decent=0 end
  local miss = tonumber(SCREENMAN:GetTopScreen():GetChild('MissNumberP' .. pn+1):GetText())
  local all = (blue + white + excellent + great + decent + miss)
  -- Congratulate the effort required to reach this corner case.
  if all == 0 then return "=^_^=" end

  local percent_blues = 100 * blue / (blue + white + excellent + great + decent + miss)
  return string.format("%0.2f", percent_blues)
end

function GetStaminaFaPlusScore(pn)
  local blue = SCREENMAN:GetTopScreen():GetChild('MarvelousNumberP' .. pn+1):GetText()
  local white = SCREENMAN:GetTopScreen():GetChild('PerfectNumberP' .. pn+1):GetText()
  return blue + (0.5 * white)
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
    return GetStaminaFaPlusScore(pn), "Stamina FA+"
  elseif IsEcfaPack() then
    return GetFaPlusScore(pn), "FA+"
  else
    return "", ""
  end
end


