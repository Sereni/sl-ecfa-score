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

local function IsEcfaPack()
  return 
    GAMESTATE:GetCurrentSong():GetGroupName() == "ECFA 2019 - Lower" or
    GAMESTATE:GetCurrentSong():GetGroupName() == "ECFA 2019 - Middle" or
    GAMESTATE:GetCurrentSong():GetGroupName() == "ECFA 2019 - Upper"
end

local function EcfaScore()
  if SL.Global.GameMode == "ECFA" then
    -- Check if Stamina FA
    if IsStaminaFA() then
      return GetStaminaFaPlusScore()
    elseif IsEcfaPack() then
      return GetFaPlusScore()
    else
      return ""
    end
  -- Regular FA mode
  else
    if IsStaminaFA() then
      return GetStaminaFaScore()
    elseif IsEcfaPack() then
      return GetFaScore()
    else
      return ""
    end
  end
end

-- Names the formula used to calculate score 
local function ScoreLabel()
  if SL.Global.GameMode == "ECFA" then
    if IsStaminaFA() then
      return "Stamina FA+"
    elseif IsEcfaPack() then
      return "FA+"
    else
      return ""
    end
  -- Regular FA mode
  else
    if IsStaminaFA() then
      return "Stamina FA"
    elseif IsEcfaPack() then
      return "FA"
    else
      return ""
    end
  end
end

-- Display the score
t = Def.ActorFrame {
  InitCommand=function(self)
    self:xy(25, _screen.cy - 70)
    if pn == PLAYER_1 then
      self:x(-25)
	end
  end,
  LoadFont("_wendy small")..{
	InitCommand=function(self)
	  self:zoom(0.4)
          self:settext(EcfaScore())
        end,
  }
}

-- Add a label to tell the player which formula was used
t[#t+1] = Def.BitmapText{
            Font="_miso",
            InitCommand=function(self)
              self:settext(ScoreLabel())
              self:y(-20)
              self:zoom(0.7)
            end,
}
return t