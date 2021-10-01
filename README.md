# Friday Night Funkin': VS Selever
This repository hosts a public copy of the sources and assets used for the VS Selever mod of Friday Night Funkin'.

The project itself was built on top of [Kade Engine 1.6](https://github.com/KadeDev/Kade-Engine), and includes a few enhancements on top of it, namely a more flexible dialog system that allows you to add dialogues either before or after any stage in story mode with no need to touch the game's source code. Hopefully that will help us with future mods or updates that may come.

Feel free to navigate the source code in order to fetch any feature you like from our mod.

## Building

If you want to build a copy of this mod yourself, here's what you need:

* Windows 10 or some compatible system. Virtual machines work well enough.
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
After you've been through all that you will finally be able to build this program. We apologize for so many dependencies, they were out of our control.

## FAQs about the project
#### Q: What motivated you guys to create the mod?
**A:** We have fun creating different things and sharing them, some of us enjoy composing music, others are good with art, others like programming stuff. It all began with a fanmade song one of us made for Selever, the idea for the mod came to be after seeing the positive reception it got. We also thought Selever deserved something better than just a poorly received joke update, so the project leader decided to see who he could get in contact with in order to get enough material for a full week.

#### Q: How long did this took to make?
**A:** Putting the pieces and code together took about a week, although most of the assets were being worked on for longer. It's safe to say overall this mod took about a month to reach its first release.

#### Q: Is this mod canon to Mid-Fight Masses?
**A:** Since none of the former MFM team members was part of this project, it's definitely not canon. This is just a fanmade mod, made for fun.

#### Q: Did you guys get permission before publishing this mod?
**A:** No. We exhausted all our options to get in contact with the one remaining member of the former Mid-Fight Masses team, Mike Geno, in order to let him know about the project. Unfortunately, we weren't able to get a single message back from him. We tried indirect channels, but none of our contacts had luck contacting him either. The fact none of the core team members has an active Twitter profile probably hindered our efforts as well. So we couldn't get express approval for the mod, as much as we would have loved to.

#### Q: Selever has some rather rude words towards people during the third set of dialogues. Who was it aimed to?
**A:** Selever's angry rant was aimed to the people who harassed the MFM staff over pointless details like poor charting and engine faults, even tho multiple solutions offered by third parties existed at that point; since in our characterization Selever is aware of what happened and he blames the people out there for the demise of his parents, you could say that's a sore spot for him at the moment.
Since this question has been asked often enough, we have updated the dialogue script in order to reduce the ambiguity. We're sorry for the discomfort this may have caused, unless you were one of those people bashing MFM back in the day. If that's the case, yeah, suck it up.

#### Q: Are there any future plans for this mod?
**A:** We will most likely update the mod in the future with more free-play mode songs, mainly covers of existing songs out there. Adding new weeks is unlikely to happen though.

#### Q: Do you guys plan to add other characters like Rasazy? Please say yes! / Please don't!
**A:** We do not plan to add Rasazy or other characters to this mod, since it's meant to be all about Selever. It is called _Friday Night Funkin': VS Selever_, after all. If you were expecting a week for Rasazy, sorry to disappoint you. If you didn't, rest easy.

#### Q: I've heard Blansephx had plans for a Rasazy mod. Were you guys aware of that? Does it have something to do with this mod?
**A:** While we were aware of Blansephx's idea for a Rasazy mod when he was incorporated to the team; all we asked from him were some illustrations for the Selever mod, since we saw he was well capable of making them. His project is not related to ours, and he does not make any decisions in the direction of this project. He's just the illustrator, so please don't bash him over the existence of this mod.

#### Q: This mod is unacceptable! What can I do to stop it?
**A:** Since the mod is stable and already out in the wild, the best way you can counter its momentum is suffocating it with other, more positive topics. Maybe talk about other mods you like, or share fanart of your favorite characters; but whatever you do it's best to keep calm and try to get others to stay calm as well. There are still a handful of people who are better suited to address any issues with the mod, and they can do it, but putting more stress on their shoulders won't help them one bit. Fueling drama will only bring more attention towards this mod, which in turn will lead to more views and downloads, downloads that in the event of a "cancellation" could lead to clandestine reuploads. That's less than ideal for a mod you wish to get rid of.