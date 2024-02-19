# EmuGames Powershell Compression Scripts #
Work in progress, I will try to keep everything functional but there will most likely be major changes down the road.
## Usage ##
All of these scripts are ment to be ran in the same folder as the game files, just extract into the folder with the files you want compressed, navigate to said folder in powershell and and run `.\script.ps1` replacing "script" with whichever one you want to use. 

**IMPORTANT: By default these scripts are set up to remove the files as they are converted, if you do not want the original files to be deleted comment out  the "Remove-Item" lines**

### PSP\PS2: CSO to CHD ###
Batch convert PSP and PS2 games that have previously been compressed as CSO files.
For use with 
[PPSSPP](https://github.com/hrydgard/ppsspp) &
[PCSX2](https://github.com/PCSX2/pcsx2)

### Xbox 360: ISO to ZAR ###
Batch compress Xbox 360 ISO files to ZAR
For use with
[Xenia](https://github.com/xenia-project/xenia)


### Tools Used ###
[chdman](https://github.com/mamedev/mame),
[maxcso](https://www.google.com](https://github.com/unknownbrackets/maxcso)https://github.com/unknownbrackets/maxcso),
[zarchive](https://github.com/Exzap/ZArchive),
[extract-xiso](https://github.com/XboxDev/extract-xiso)
