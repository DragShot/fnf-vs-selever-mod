# Friday Night Funkin': VS Selever
This repository hosts a public copy of the sources and assets used for the VS Selever mod of Friday Night Funkin'.

The project itself was built on top of [Kade Engine 1.6](https://github.com/KadeDev/Kade-Engine), and includes a few enhancements on top of it, namely a more flexible dialog system that allows you to add dialogues either before or after any stage in story mode with no need to touch the game's source code. Hopefully that will help us with future mods or updates that may come.

Feel free to navigate the source code in order to fetch any feature you like from our mod.

## Building

If you want to build a copy of this mod yourself, here's what you need:

* Windows 10 or some compatible system. Virtual machines work good enough.
* [Haxe 4.1.5](https://haxe.org/download/version/4.1.5/)
* [HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/)
* [Visual Studio Code](https://code.visualstudio.com)
* [Visual Code Build Tools 2019](https://visualstudio.microsoft.com/downloads/): Install modules `MSVC v142 - VS 2019 C++ x64/x86 build tools` and `Windows SDK (10.0.17763.0)` only.
* Run the following commands to install the modules required by Kade Engine:
```
haxelib install lime
haxelib install openfl
haxelib install flixel
haxelib install flixel-addons
haxelib install flixel-ui
haxelib install hscript
haxelib install newgrounds
haxelib run lime setup
haxelib install flixel-tools
haxelib install linc_luajit
haxelib run flixel-tools setup
haxelib git polymod https://github.com/larsiusprime/polymod.git
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons
haxelib install actuate
haxelib git extension-webm https://github.com/KadeDev/extension-webm
haxelib install openfl-webm
lime rebuild extension-webm windows
```
After you've been through all that you will finally be able to build this program. We're sorry there are so many dependencies, they were out of our control.
