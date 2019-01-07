-- Calculates and displays score for ECFA19

local pn = ...
local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)

local function GetFaScore()
  local fantastics = stats:GetTapNoteScores("TapNoteScore_W1")
  local misses = stats:GetTapNoteScores("Miss")
  local minesHit = stats:GetRadarPossible():GetValue("RadarCategory_Mines") - stats:GetRadarActual():GetValue("RadarCategory_Mines")
  local holdsDropped = stats:GetRadarPossible():GetValue("RadarCategory_Holds") - stats:GetRadarActual():GetValue("RadarCategory_Holds")
  local rollsDropped = stats:GetRadarPossible():GetValue("RadarCategory_Rolls") - stats:GetRadarActual():GetValue("RadarCategory_Rolls")
  return fantastics - 0.5 * (misses + minesHit + holdsDropped + rollsDropped)
end

local function GetFaPlusScore()
  -- FA+ score is a % of blue fantastics.
  local blue = stats:GetTapNoteScores("TapNoteScore_W1")
  local white = stats:GetTapNoteScores("TapNoteScore_W2")
  local excellent = stats:GetTapNoteScores("TapNoteScore_W3")
  local great = stats:GetTapNoteScores("TapNoteScore_W4")
  local decent = stats:GetTapNoteScores("TapNoteScore_W5")
  local miss = stats:GetTapNoteScores("Miss")
  local percent_blues = 100 * blue / (blue + white + excellent + great + decent + miss)
  return string.format("%0.2f", percent_blues)
end

local function GetStaminaFaScore()
  local fantastics = stats:GetTapNoteScores("TapNoteScore_W1")
  return fantastics
end

local function GetStaminaFaPlusScore()
  local blue = stats:GetTapNoteScores("TapNoteScore_W1")
  local white = stats:GetTapNoteScores("TapNoteScore_W2")
  return blue + (0.5 * white)
end

local function IsStaminaFA()
  return GAMESTATE:GetCurrentSong():GetGroupName() == "ECFA 2019 - Stamina FA"
end

local function EcfaScore()
  if SL.Global.GameMode == "ECFA" then
    -- Check if Stamina FA
    if IsStaminaFA() then
      return GetStaminaFaPlusScore()
    else
      return GetFaPlusScore()
    end    
  else
    if IsStaminaFA() then
      return GetStaminaFaScore()
    else
      return GetFaScore()
    end    
  end
end


t = Def.ActorFrame {
  InitCommand=function(self)
    self:xy(20, _screen.cy - 70)
    if pn == PLAYER_1 then
      self:x(-20)
	end
  end,
  LoadFont("_wendy small")..{
	InitCommand=function(self)
	  self:zoom( 0.4 )
      self:settext(EcfaScore())
    end,
  }
}
return t