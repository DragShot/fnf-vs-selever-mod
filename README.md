# Friday Night Funkin': VS Selever
This repository hosts a public copy of the sources and assets used for the VS Selever mod of Friday Night Funkin'.

The project itself was built on top of [Psych Engine 0.5.1](https://github.com/ShadowMario/FNF-PsychEngine), and includes a few enhancements on top of it, namely an autoload function for the dialog system that allows you to add dialogues either before or after any stage in Story Mode with no need to set triggers through any lua scripts, and localization support for said dialogues. Hopefully that will help us with future mods that may come.

Feel free to navigate the source code in order to fetch any feature you like from our mod.

## Building

If you want to build a copy of this mod yourself, here's what you need:

* Windows 10 or some compatible system. Virtual machines work well enough.
* [Haxe 4.1.5](https://haxe.org/download/version/4.1.5/)
* [HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/)
* [Visual Studio Code](https://code.visualstudio.com)
* [Visual Code Build Tools 2019](https://visualstudio.microsoft.com/downloads/): Install modules `MSVC v142 - VS 2019 C++ x64/x86 build tools` and `Windows SDK (10.0.17763.0)` only.
* Run the following commands to install the modules required by Psych Engine:
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
Once you have setup all that you should be able to build this program. Run the command `lime build windows` to do it.

## FAQs about the project
**Q: What motivated you guys to create the mod?**
**A:** We have fun creating different things and sharing them, some of us enjoy composing music, others are good with art, others like programming stuff. It all began with a fanmade song one of us made for Selever, the idea for the mod came to be after seeing the positive reception it got. We also thought Selever deserved something better than just a poorly received joke update, so the project leader decided to see who he could get in contact with in order to get enough material for a full week.

**Q: How long did this took to make?**
**A:** Putting the pieces and code together took about a week, although most of the assets were being worked on for longer. It's safe to say overall this mod took about a month to reach its first release. The second major release took about three weeks to make, including the port from Kade to Psych Engine, composing the new song, commissioning a new set of sprites and reworking the charts.

**Q: Is this mod canon to Mid-Fight Masses?**
**A:** Since none of the former MFM team members was part of this project, it's definitely not canon. This is just a fanmade mod, made for fun. We did put an effort into following what's widely known about the canon of the story Selever comes from, however.

**Q: Did you guys get permission before publishing this mod?**
**A:** No. We exhausted all our options to get in contact with the one remaining member of the former Mid-Fight Masses team, Mike Geno, in order to let him know about the project. Unfortunately, to this day we haven't been able to get a single message back from him. We tried going through indirect channels, but none of our contacts had luck contacting Mike either, as he seems to have closed his inbox to anyone he isn't acquainted with. At this point we have given up in our attempts to get express approval for the mod, a situation no different than those of pretty much every other fanmade mod about Mid Fight Masses out there. The only exception known at the time this FAQ was updated is Date Night Masses, which has yet to make an initial release.

**Q: Why make a Selever mod then?**
**A:** Once again, we did it for fun. The one reason we greenlit the project however was Dokki-Doodlez's statement about the FNF community being free to enjoy the MFM characters as they see fit, as long as nobody comes knocking at her door about it anymore. This was posted as a story hours before she closed her previous Instagram account.

**Q: Selever has some rather rude words towards people during the third set of dialogues. Who was it aimed to?**
**A:** Selever's angry rant was aimed to the people who harassed the MFM staff over pointless details like poor charting and engine faults, even tho multiple solutions offered by third parties existed at that point; since in our characterization Selever is aware of what happened and he blames the people out there for the demise of his parents, you could say that's a sore spot for him at the moment.

Since this question has been asked often enough, we have updated the dialogue script in order to reduce the ambiguity. We're sorry for the discomfort this may have caused, unless you were one of those people bashing MFM back in the day. If that's the case, yeah, suck it up.

**Q: Are there any future plans for this mod?**
**A:** At this point in production, we are satisfied with the state of the mod and consider it a completed project. It is unlikely we will add any new content to it, other than maintenance patches if the need for any of those ever arises.

**Q: Do you guys plan to add other characters like Rasazy? Please say yes! / Please don't!**
**A:** We did not plan to add Rasazy or other characters to this mod, since it's meant to be all about Selever. It is called _Friday Night Funkin': VS Selever_, after all. If you were expecting a week for Rasazy, we're sorry to disappoint you. If you didn't, rest easy.

**Q: I've heard Blansephx had plans for a Rasazy mod. Were you guys aware of that? Does it have something to do with this mod?**
**A:** While we were aware of Blansephx's idea for a Rasazy mod when he was incorporated to the team; all we asked from him were some illustrations for the menu background of the Selever mod, since we saw he was well capable of making them. His project is not related to ours, and he did not make any decisions in the direction of this project. He was just the illustrator, and his participation was rather short-lived after he started to engage in arguments on Twitter about his involvement in MFM-related mods. As result, we decided not to work with him for the 2.0 update, and he is no longer part of the team. He now remains as a 3rd-party contributor, as his illustrations were still considered fit for the mod.

**Q: This mod is unacceptable! What can I do to stop it?**
**A:** We're sorry to inform you that once something is up on the Internet, it's there to stay. The work has been done, negotiations have been attempted, and the results are here. At this time, all work in this mod has concluded, so anyone willing to give it a chance may play it, and everyone else are free to ignore it and move on with their lives. If you are looking for an approved spin-off of Mid-Fight Masses, you are invited to check out [Date Night Masses](https://fridaynightfunking.fandom.com/wiki/Date-Night_Masses), an ongoing project that will feature its own songs as well as some of the characters from MFM, and so far the only one that has been successful in getting a positive reply from Mike Geno, or any at all for that matter.