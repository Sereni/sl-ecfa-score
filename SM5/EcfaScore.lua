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
  local blue = stats:GetTapNoteScores("TapNoteScore_W1")
  local white = stats:GetTapNoteScores("TapNoteScore_W2")
  return blue + 0.5 * white
end

local function EcfaScore()
  if SL.Global.GameMode == "ECFA" then
    return GetFaPlusScore()
  else
    return GetFaScore()
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