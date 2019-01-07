# Simply Love ECFA19 score mod
This mod calcualtes and displays your ECFA19 score for various divisions.

## Installation instructions
If you are not willing to mess up and fix your theme, wait until the mod is officially released in ECFA themes in Round 2 update.

Otherwise, first create a copy of your entire theme folder, so that you can easily undo changes. Your theme folder will be in `Themes/`, called something like "Simply Love".

### SM5
Download the SM5/EcfaScore.lua file and copy it into this folder:

`Stepmania/Themes⁩/⁨your-theme-name/BGAnimations⁩/⁨ScreenEvaluation common⁩/⁨PerPlayer⁩/` 

Open the following file with a text editor.

`Stepmania/Themes⁩/⁨your-theme-name/BGAnimations⁩/⁨ScreenEvaluation common⁩/⁨default.lua`

Find this line in default.lua:

`LoadActor("./PerPlayer/LetterGrade.lua", player),`

Paste the this line after it and save the file:

`LoadActor("./PerPlayer/EcfaScore.lua", player),`

You can use the example SM5/default.lua from this repository to find where you need to make the change.

## Troubleshooting

**My entire score page is gone!**

default.lua is invalid. Possible reasons:
- New line you added are in the wrong place. Check with the example.
- Any other lines have changed. Check with your backup copy of the file.
- Your text editor replaced line endings. This can happen, for example, with Notepad on Windows. Replace modified file with your backup copy, then open that file with a different editor, for example, Notepad++.

**Letter and stars do not show anymore**

You may have deleted this line: `LoadActor("./PerPlayer/LetterGrade.lua", player),`. Paste it back.
