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

### OpenITG/Stock
Download the Stock/EcfaScore.lua file and copy it into this folder:

`your-additional-folder/Themes⁩/⁨your-theme-name/Scripts⁩/`

Download the 'Stock/ScreenEvaluation overlay.xml' file. Make a backup of this file, then replace it with the one you downloaded:

`your-additional-folder/Themes/your-theme-name/BGAnimations/ScreenEvaluation overlay.xml`

## Troubleshooting

**My entire score page is gone!**

default.lua is invalid. Possible reasons:
- New line you added are in the wrong place. Check with the example.
- Any other lines have changed. Check with your backup copy of the file.
- Your text editor replaced line endings. This can happen, for example, with Notepad on Windows. Replace modified file with your backup copy, then open that file with a different editor, for example, Notepad++.

**Letter and stars do not show anymore**

You may have deleted this line: `LoadActor("./PerPlayer/LetterGrade.lua", player),`. Paste it back.

**Nothing breaks, but nothing extra displays either**

The script relies on some pretty specific names of various things.
- For Stamina FA/FA+, make sure your songs are in a folder called "ECFA 2019 - Stamina FA".
- For non-stamina FA/FA+, make sure your songs are in a folder called one of these exactly:
  - "ECFA 2019 - Lower"
  - "ECFA 2019 - Middle"
  - "ECFA 2019 - Upper"
- For FA+ or Stamina FA+ on stock, make sure your theme name includes "ECFA".

## Thanks
To The Right Honourable Sir Darren Smith of Uxbridge for saying that it would be nice to have score calculated for you and put on the screen.

To CrowTheShaman for figuring out Stamina FA.
