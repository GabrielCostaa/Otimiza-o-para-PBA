ANTI-STUTTER OPTIMIZATION - Pokémon Battle Advanced 0.3.3
========================================================

PROBLEM
While moving around the map, the game experiences minor stutters (hiccups lasting 25–50 ms), even on powerful PCs. The cause is the game's default graphics driver (Direct3D 12).

WHAT IT DOES
Switches the graphics driver to Vulkan, which the game already supports.
Estimated results (RTX 4090, walking from Pallet Town to Route 2 and back):
  - Stutters while moving (>25 ms): 139–176 → 26–30 (approx. 80% reduction)
  - Stutters while standing still (20 s): 48–59 → 5–12
  - Identical visuals (compare screenshots taken with both drivers)
Results may vary on less powerful PCs.

HOW TO INSTALL
1. Extract this .zip file to any folder.
2. Double-click INSTALAR.bat.
   (It will attempt to locate the game folder automatically; if it fails, a window
   will appear, prompting you to select the folder containing PokémonBattleAdvanced.exe.)
3. Launch the game as usual.

You may experience some stuttering the first time you play, as the game builds its Vulkan shader cache. Afterward, gameplay will be smooth.

HOW TO UNINSTALL
Double-click DESINSTALAR.bat. The game will revert to using Direct3D 12.

NOTES
- This does NOT modify the game's .exe or .pck files, nor does it affect your save data. Instead, it adds a line to the override.cfg file located in the game folder.
- Compatible with the Mod Menu: both installers merge changes into the override.cfg file rather than overwriting it, ensuring neither mod removes the other.
- Designed for version 0.3.3-preview (Godot 4.7). You need a graphics card
  with Vulkan support (practically any card from the last few years).
- If the game doesn't open after installation, run UNINSTALL.bat.
