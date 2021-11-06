File Folder Madness
===================
I hate that windows does not (and by extension Linux) a quick way to look at folders (natively) to discern folder space/usage.

That has been solved.

Usage
-----
`./ListFiles.sh folders <path>`

TODO
----
Add Files? (or ... just do a ../ for a path, and compare notes to when you run the ./ and see folder consumption of space)

Example C:\
===========
Ran as `./ListFiles.sh folders /mnt/c/`:  
```
FOLDER (/mnt/c/) Sizes:
================================================================================
(  829.57 GiB   ) | 890740319000.. | 100.0% | .
--------------------------------------------------------------------------------
(    3.88 GiB   ) | 4165846000.... | <1.00% | ./$GetCurrent
(    0    B     ) | 0000.......... | <1.00% | ./$Recycle.Bin
(    0    B     ) | 0000.......... | <1.00% | ./$WinREAgent
(   32.08 MiB   ) | 33636000...... | <1.00% | ./DRIVERS
(    0    B     ) | 0000.......... | <1.00% | ./EA Core
(    1.26 MiB   ) | 1316000....... | <1.00% | ./Electronic Arts
(    2.78 GiB   ) | 2981319000.... | <1.00% | ./eSupport
(   21.87 GiB   ) | 23481073000... | 02.00% | ./Games
(    0    B     ) | 0000.......... | <1.00% | ./Microsoft
(    3.91 KiB   ) | 4000.......... | <1.00% | ./MSOCache
(   76.67 GiB   ) | 82326016000... | 09.00% | ./My_Files_Ubuntu
(  705.79 MiB   ) | 740074000..... | <1.00% | ./PP_games_to_migrate
(    8.45 GiB   ) | 9075746000.... | 01.00% | ./Program Files
(  504.07 GiB   ) | 541244317000.. | 60.00% | ./Program Files (x86)
(    3.80 GiB   ) | 4084947000.... | <1.00% | ./ProgramData
(  644.53 KiB   ) | 660000........ | <1.00% | ./Screenshots
(   12.78 MiB   ) | 13400000...... | <1.00% | ./SYS209
(  184.65 GiB   ) | 198266414000.. | 22.00% | ./Users
(   19.27 GiB   ) | 20692075000... | 02.00% | ./Windows
(    3.30 GiB   ) | 3543221000.... | <1.00% | ./Windows10Upgrade
--------------------------------------------------------------------------------
(  829.48 GiB   ) | 890650064000.. | Subfolders account for: 99.00% of space used
```

Ran as `./ListFiles.sh folders /mnt/c/Program\ Files\ \(x86\)/Steam/steamapps/common/`:  
```
FOLDER (/mnt/c/Program Files (x86)/Steam/steamapps/common/) Sizes:
================================================================================
(  372.20 GiB   ) | 399647648000.. | 100.0% | .
--------------------------------------------------------------------------------
(  495.12 MiB   ) | 519173000..... | <1.00% | ./001 Game Creator
(   17.57 MiB   ) | 18428000...... | <1.00% | ./3DMark
(  238.28 KiB   ) | 244000........ | <1.00% | ./Aegis Defenders
(    8.49 GiB   ) | 9113612000.... | 02.00% | ./Bloodstained Ritual of the Night
(   35.41 MiB   ) | 37132000...... | <1.00% | ./Carcassonne The Official Board Game
(  323.91 MiB   ) | 339646000..... | <1.00% | ./Cosmoteer
(   31.25 KiB   ) | 32000......... | <1.00% | ./Crysis
(    7.81 KiB   ) | 8000.......... | <1.00% | ./Crysis Warhead
(   38.09 GiB   ) | 40902364000... | 10.00% | ./DIRT 5
(  363.10 MiB   ) | 380736000..... | <1.00% | ./Don't Starve Together
(  235.61 MiB   ) | 247053000..... | <1.00% | ./Drawful 2
(    3.49 MiB   ) | 3664000....... | <1.00% | ./Fallout76
(    1.44 GiB   ) | 1544459000.... | <1.00% | ./Final Fantasy 6
(    1.40 GiB   ) | 1503025000.... | <1.00% | ./FINAL FANTASY VII
(  266.92 MiB   ) | 279889000..... | <1.00% | ./FTL Faster Than Light
(    1.53 GiB   ) | 1645339000.... | <1.00% | ./Godot Engine
(   93.79 GiB   ) | 100705399000.. | 25.00% | ./Halo The Master Chief Collection
(    6.19 GiB   ) | 6646168000.... | 01.00% | ./Hammerting
(    4.34 GiB   ) | 4658830000.... | 01.00% | ./Kerbal Space Program
(  393.69 MiB   ) | 412812000..... | <1.00% | ./Muck
(  589.86 MiB   ) | 618508000..... | <1.00% | ./Nowhere Prophet
(  700.05 MiB   ) | 734052000..... | <1.00% | ./Out of Space
(    7.81 KiB   ) | 8000.......... | <1.00% | ./Patchwork
(    1.07 GiB   ) | 1149428000.... | <1.00% | ./Paw Paw Paw
(  257.81 KiB   ) | 264000........ | <1.00% | ./PCMark 10
(   10.96 MiB   ) | 11488000...... | <1.00% | ./Portal
(   11.58 GiB   ) | 12435847000... | 03.00% | ./Portal 2
(  116.64 GiB   ) | 125240400000.. | 31.00% | ./Red Dead Redemption 2
(    6.39 GiB   ) | 6863922000.... | 01.00% | ./Rocksmith2014
(  316.41 KiB   ) | 324000........ | <1.00% | ./RPGVXAce
(  272.62 MiB   ) | 285860000..... | <1.00% | ./SmallWorld2
(   31.60 GiB   ) | 33928019000... | 08.00% | ./SpaceEngineers
(    1.27 GiB   ) | 1367854000.... | <1.00% | ./StarMade
(    4.49 GiB   ) | 4817518000.... | 01.00% | ./SteamVRPerformanceTest
(  407.26 MiB   ) | 427048000..... | <1.00% | ./Steamworks Shared
(   10.84 GiB   ) | 11640637000... | 02.00% | ./Stellaris
(    0    B     ) | 0000.......... | <1.00% | ./Stubbs the Zombie
(  483.98 MiB   ) | 507488000..... | <1.00% | ./Super Meat Boy
(    2.65 GiB   ) | 2846736000.... | <1.00% | ./Tabletop Simulator
(   22.27 GiB   ) | 23915055000... | 05.00% | ./Team Fortress 2
(  590.34 MiB   ) | 619021000..... | <1.00% | ./The Binding of Isaac Rebirth
(    1.48 GiB   ) | 1590676000.... | <1.00% | ./The Jackbox Party Pack 7
(    1.36 GiB   ) | 1459854000.... | <1.00% | ./The Jackbox Party Pack 8
(  601.56 KiB   ) | 616000........ | <1.00% | ./VRMark Demo
(  218.41 MiB   ) | 229016000..... | <1.00% | ./Zenimax Online
--------------------------------------------------------------------------------
(  372.20 GiB   ) | 399647652000.. | Subfolders account for: 100.00% of space used
```