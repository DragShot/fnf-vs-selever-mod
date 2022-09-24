--------------------------------------------------------------------------------
-- DS Dialogue System for Psych Lua                            ©DragShot - v1.0
--------------------------------------------------------------------------------
-- Usage in any mods is allowed as long as this header is kept intact. Also,
-- please give me credits somewhere.
-- In order to make use of it, save this script inside 'mods/scripts/', then
-- folow the instructions below. 
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- The good stuff:
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- - New dialogue globes as easy to customize as replacing an image. You can add
--   your own as well by creating a new image with the right name. Normal,
--   shouting and thinking dialogue globes are included by default.
-- - The dialogue can be skipped anytime by pressing [Esc] or [Backspace].
-- - Support for animated gestures. The gesture animation is played once per
--   letter typed.
-- - Skins able to define their own images, text fonts and their positions on
--   the screen.
-- - Support for latin and other extended characters (as UTF-8).
-- - An optional label for character names.
-- - Support for custom typing sounds for each character. These are loaded
--   automatically from 'mods/sounds/dialogue/<your_character>.ogg' if possible.
-- - Voice-over lines can be declared for each dialogue. When this happens,
--   the typing sounds are not used for that line, and instead the voice line is
--   played.
-- - Dialogues use text files with an easy to write format. A GUI editor may be
--   included later tho.
-- - Control commands (if/else), so you can have different dialogues according
--   to a given codition.
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Disadvantages
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- - Not compatible with Psych's json dialogues for now.
-- - Not compatible with Psych's portraits for now. Portraits are instead read
--   directly from 'mods/images/dialogue', and their animations are expected to
--   be of a fixed size (480x480px for the default skin) and looking to the
--   right in order to be aligned correctly. You can however use texture atlas
--   offsets to realign frames of different sizes.
-- - Psych Engine builds with no support for the `io` package may limit the
--   functionality of the script, mainly the bits handling custom audio (type
--   sounds and voiceovers).
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Instructions
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- To start a dialogue, call the following event from your Psych script, instead
-- of the usual `startDialogue()` function:
-- 
--   triggerEvent('startDialogue', dialogueName, bgMusic);
-- 
-- You can also preload a dialogue in order to avoid lag when you call it later:
--
--   triggerEvent('loadDialogue', dialogueName);
-- 
-- Dialogue files will be loaded from your song's data folder.
--
-- You can also listen for events whose name start with 'dialogue.'. These
-- events will report progress as the player advances through the steps of the
-- dialogue, or let you know if they skipped it.
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Writing Dialogues
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Dialogues for this system are contained in text files, where each line has
-- one of the following commands:
-- 
-- 1. Dialogue: Shows a character saying something on screen. The line looks
--    like this:
--
--      @dialogue pos="R" portrait="bf" nameTag="Boyfriend.xml" text="Beep!" dbox="shout" speed="0.05" voclip="test/bf_beep"
--
--      -> 'pos' can be either "L" or "R", depending on where the portrait
--         should appear on the screen.
--      -> 'portrait' is the name of the image atlas inside 'mods/images/
--         dialogue' to use for the portrait. You can include a specific
--         expression as well with a semicolon. For instance, "bf:happy"
--         will play the animation 'happy' from the atlas 'mods/images/
--         dialogue/bf.xml'. The animation 'default' is played by default.
--      -> 'nameTag' has a name to display below the character's portrait.
--         It usually is expected to be their name.
--      -> 'text' is what the character has to say.
--      -> 'dbox' is the image to use for the dialogue globe. The default
--         "normal" value points to 'mods/images/ds/dialogue/dbox_normal.png'.
--      -> 'speed' has the time interval between letters. The closer this value
--         is to zero, the higher the typing speed will be.
--      -> 'voclip' has the location of a sound file inside 'mods/sounds/' for
--         usage as a voice-over clip.
--
--    You may omit the properties 'nameTag', 'dbox', 'speed' and 'voclip' if
--    you don't need them, so the following works:
--
--      @dialogue pos="R" portrait="bf" text="Beep!"
--
-- 2. Play Sound: Allows you to play a sound between dialogues.
--
--      @playSound src="cancelMenu" tag="cancelSfx" vol="1.0"
--
--      -> 'src' has the location of the sound inside 'mods/sounds'. The sound
--         is expected to be an .ogg file.
--      -> 'tag' is a name for this given sound, which you can use to replace
--         or stop it at any time. Can be ommited.
--      -> 'vol' is the playback volume (0.0 to 1.0). Can be ommited.
--
-- 3. Stop Sound: Allows you to stop a sound that had previously started to play.
--
--      @stopSound tag="cancelSfx"
--
--      -> 'tag' is the name given to the sound you want to stop.
--
-- 4. Trigger Event: It triggers any event you want via `triggerEvent()`.
--
--      @event "Custom Event" "value1" "value2"
--
--    The parameters expected are the event name and its two values.
--
-- 5. Wait: It stops the dialogue for a moment. You can use this time to let a
--    sound play or something.
--
--      @wait time="1s"
--
--      -> 'time' defines how long the pause will last. It can be specified in
--         seconds (s) or milliseconds (ms).
--
-- 6. Background change: It lets you change the background of the dialogue to
--    something else, like an image or a solid color. You can also pick between
--    a bunch of predefined transition effects, this can be particularly useful
--    for changing scenarios, fullscreen slides or comic-like cutscenes.
--
--      @bgChange src="path/to/file" pos="0,0" scale="1.0,1.0" transition="colorfade" time="2s" focused="true" color="000000"
--
--      -> 'src' has the location of the image inside 'mods/images'. The image
--         is expected to be a .png file.
--      -> 'pos' has the X and Y position coordinates relative to the canvas,
--         separated by commas.
--      -> 'scale' has the X and Y scaling proportions for the background
--         sprite, separated by commas.
--      -> 'color' has an RGB color encoded as a hex. You can set this value
--         instead of 'src', 'pos' and 'scale' in order to use a background of
--         a solid color covering the entire screen, not an image.
--      -> 'transition' defines the effect to apply when changing from the
--         previous background to this one. You can pick between:
--         - 'crossfade': Does a progressive blend between the two backgrounds.
--           Set 'time' to asign a duration for it.
--         - 'colorfade': Fades the previous background to a given color first,
--           then fades that to the new background. The color will be picked up
--           from the property 'color'. Set 'time' to asign a duration for it.
--         - 'shake': Cuts to the next background image/color and shakes the
--           screen for as long as defined by the property 'time'. You may set
--           'intensity' to control how much the screen will shake. You may set
--           'flash' with an RGB color for the screen to briefly flash in it as
--           it begins to shake.
--         - 'none': Cuts to the next background image/color immediately.
--      -> 'focused' can be set to "true" for the dialogue panels to be
--         temporarily hidden while the transition, if any, takes effect.
--
-- 7. Background move: It lets you move the existing background around the
--    screen. It works best with image backgrouds.
--
--      @bgMove pos="-400,-400" scale="1.05,1.05" time="4s" ease="sinOut" focused="false"
--
--      -> 'pos' and 'scale' work the same way as in @bgChange. They are to be
--         considered effective when the movement animation ends.
--      -> 'time' defines the time the movement will take to complete.
--      -> 'ease' defines the easing animation to follow during the movement.
--         Any value accepted by Psych is valid here.
--      -> 'focused' can be set to "true" for the dialogue panels to be
--         temporarily hidden while the animation takes effect.
--
-- 8. End Dialogue: Ends the dialogue at the given position, ignoring everything
--    that comes after. The line looks like this:
--
--      @endDialogue "Bad Ending"
--
--    It accepts only one value, a label used in the event this script will
--    emit signaling the end of the dialogue as result of this command.
--
-- 9. Control-IF: It lets you have branches with different dialogues according
--    to a given condition. All you need to do is include a Lua expression that
--    will be evaluated at load time. Here's an example:
--
--      #if "songName == 'Chad Song'"
--      	@dialogue pos="R" portrait="bf" text="Beep!"
--      #else if "songName == 'GigaChad Song'"
--      	@dialogue pos="R" portrait="bf" text="Woah! So pro!" dbox="think"
--      #else
--      	@dialogue pos="R" portrait="bf" text="Ha ha! Loser!" dbox="shout"
--          @endDialogue "Bad Ending"
--      #end
--      @dialogue pos="R" portrait="bf:happy" text="Coolswag!"
--
-- You can include double quotes (") in your values by typing \", and linesplits
-- by typing \n like this:
--
--   text="Here is a \"line\" of text.\nAnd here is another!"
--
-- NOTE: It is important to use manual linesplits in your dialogues because
-- there is no way for this script to figure out the spacing at the moment.
--
-- At the moment you can only write these by hand, but a GUI-based editor may be
-- created later if enough people show interest in having one.
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Multi-language Support
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- This script can load different dialogue files based on language. For this,
-- your build of Psych Engine needs a Lua callback called `getLangCode()` that
-- returns a short language code (like those used in a browser), corresponding
-- to the language chosen by the player. When this is available, the returned
-- code will be prepended to the file extension like this:
-- 
-- -> For 'my-dialogue' and language code 'es', the file to load will be:
--    'mods/data/my-song/my-dialogue.es.txt'
--    If the file doesn't exist, the file to load as fallback will be:
--    'mods/data/my-song/my-dialogue.txt'
--
-- There is a dummy function included in this script that will return the
-- default code 'en', for English.
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Compatibility layer with Vs Selever (PE 0.5.1-xt) for Psych Engine
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- The engine would usually return the language picked by the player.
function getLangCode()
	return 'en';
end

function _pathSplice(limit)
	--Fetch the location of this script
	local path = string.sub(debug.getinfo(1).source, 2);
	local idx = 0;
	for i = 1, limit do
		idx, _ = string.find(path, '/', idx + 1, true);
	end
	path = string.sub(path, 1, idx);
	return path;
end

-- Returns the contents of a file inside 'mods/mymod/' or 'mods/'.
-- It's better to make sure it exists first before trying to read it.
function readFile(target)
	if (target == nil or target:contains('..', true)) then
		return nil; --Fuck off!
	end
	local str = nil;
	--Try with io package (<= 0.5.2)
	--i=2 -> Seach inside 'mods/modpack' folder
	--i=1 -> Seach inside 'mods' folder
	pcall(function()
		for i = 2, 1, -1 do 
			local path = _pathSplice(i);
			--debugPrint('Searching for '..path..target..'...');
			local stream = io.open(path..target, 'r');
			if (stream) then
				str = stream:read('*all');
				stream:close();
				break;
			end
		end
	end);
	--Try using the callback from 0.5.2
	if (not str) then
		pcall(function() str = getTextFromFile(target); end);
	end
	return str;
end

-- Returns `true` if a given file inside 'mods/mymod/' or 'mods/' exists and
-- it's readable, `false` otherwise.
function fileExists(target)
	if (target == nil or target:contains('..', true)) then
		return nil; --Fuck off!
	end
	local exists = false;
	pcall(function()
		for i = 2, 1, -1 do 
			local path = _pathSplice(i);
			--debugPrint('Searching for '..path..target..'...');
			local stream = io.open(path..target, 'r');
			if (stream) then
				exists = true;
				stream:close();
				break;
			end
		end
	end);
	return exists;
end

-- Do you have a text file with multiple lines? You can get them all neatly
-- bundled in an array table from here.
function readLines(file)
	local textData = readFile(file);
	if (not textData) then
		return nil;
	end
	local tlines = string.split(textData, '\n', true);
	for i = 1,#tlines,1 do
		local chr = string.len(tlines[i]);
		if (chr > 0 and string.sub(tlines[i], chr, chr) == '\r') then
			tlines[i] = string.sub(tlines[i], 1, chr-1);
		end
	end
	return tlines;
end

-- This `require` behaves like the one in the PR proposed by @cyn-8.
-- You can place any .lua modules you want to load inside 'mods/libs/',
-- 'mods/mymod/libs/' or next to where this script is.
-- In order to be able to use it, however, you must call the following
-- function once from `onCreate()`:
function deployRequire()
--if (not _G.require) then
	_G.require = function(moduleName)
		if (not moduleName) then
			return nil;
		end
		--If the thing has been loaded before, do not do it again.
		if (package.loaded[moduleName]) then
			return package.loaded[moduleName];
		end
		--Try and load it from the same folder this script is, using `io`
		local target = moduleName:gsub('%.', '%/');
		modTxt = nil;
		pcall(function()
			local paths = {
				string.sub(debug.getinfo(1).source, 2):match('@?(.*/)')..target..'.lua',
				string.sub(debug.getinfo(1).source, 2):match('@?(.*/)')..target..'/init.lua'
			};
			for i, path in ipairs(paths) do
				local stream = io.open(path, 'r');
				if (stream) then
					modTxt = stream:read('*all');
					stream:close();
				end
				if (modTxt) then break; end
			end
		end);
		--Try and load it using `readFile()`
		if (not modTxt) then
			modTxt = readFile('libs/'..target..'.lua');
		end
		if (not modTxt) then
			modTxt = readFile('libs/'..target..'/init.lua');
		end
		--If the module in question was found, load it
		if (modTxt) then
			package.loaded[moduleName] = loadstring(modTxt)();
		end
		return package.loaded[moduleName];
	end
end
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Helper Functions
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function try(fn)
	local tryBlock = { task = fn, etask = nil, ftask = nil };
	
	tryBlock.catch = function(fn)
		tryBlock.etask = fn;
		return tryBlock;
	end
	
	tryBlock.logErrors = function()
		tryBlock.etask = (function(ex) debugPrint('Error: '..tostring(ex)); end);
		return tryBlock;
	end
	
	tryBlock.finally = function(fn)
		tryBlock.ftask = fn;
		return tryBlock;
	end
	
	tryBlock.doIt = function()
		local status, result = pcall(tryBlock.task);
		if ((not status) and tryBlock.etask) then
			pcall(tryBlock.etask, result);
		end
		if (tryBlock.ftask) then
			pcall(tryBlock.ftask);
		end
	end
	
	return tryBlock;
end

function strToTime(str)
	local stime = 0;
	if (str:endsWith('ms')) then
		stime = tonumber(str:sub(1, str:len()-2))/1000;
	elseif (str:endsWith('s')) then
		stime = tonumber(str:sub(1, str:len()-1));
	else
		stime = tonumber(str); --Let's just assume seconds by default
	end
	return stime;
end

function isAny(val, ...)
	local args = { ... };
	for _, target in ipairs(args) do
		if (val == target) then
			return true;
		end
	end
	return false;
end

function mouseOver(obj, mx, my)
	local px, py, pw, ph = getProperty(obj..'.x'), getProperty(obj..'.y'), getProperty(obj..'.width'), getProperty(obj..'.height');
	if (mx >= px and mx <= px + pw and my >= py and my <= py + ph) then
		return true;
	end
	return false;
end

-- Thank you, @filmor from StackOverflow
function string.startsWith(String, Start)
   return string.sub(String, 1, string.len(Start))==Start
end

-- My own spin on it
function string.endsWith(str, sufix)
   return string.sub(str, 0 - string.len(sufix)) == sufix;
end

function string.split(str, sep, noRegexp)
	sep = sep or ' ';
	noRegexp = noRegexp or false;
	local idx = 1;
	local length = string.len(str);
	local array = {};
	while (idx <= length) do
		local nid, nlen = string.find(str, sep, idx, noRegexp);
		if (nid) then
			table.insert(array, string.sub(str, idx, nid-1));
			idx = nlen + 1;
		else
			break;
		end
	end
	if (idx <= length) then
		table.insert(array, string.sub(str, idx));
	end
	return array;
end

function string.contains(str, text, noRegexp)
	if (text == nil or text:len() == 0) then
		return false;
	end
	noRegexp = noRegexp or false;
	local idx, slen = str:find(text, 1, noRegexp);
	if (idx) then
		return true;
	else
		return false;
	end
end

function string.replace(str, sfind, srep)
	local idx = 1;
	local length = string.len(str);
	local array = {};
	while (idx <= length) do
		local nid, nlen = string.find(str, sfind, idx, true);
		if (nid) then
			table.insert(array, string.sub(str, idx, nid-1));
			table.insert(array, srep);
			idx = nlen + 1;
		else
			break;
		end
	end
	if (idx <= length) then
		table.insert(array, string.sub(str, idx));
	end
	return table.concat(array,'');
end

function string.indexOf(str, sfind, start)
	start = start or 1;
	local nid, _ = string.find(str, sfind, start, true);
	return nid;
end

function string.trim(str)
   return (str:gsub("^%s*(.-)%s*$", "%1"));
end
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Logger output module
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
local debugLvl = 3; --0: Nothing, 1: Fatal, 2: Error, 3: Warning, 4: Info, 5: Debug, 6: Verbose

function dlog(lvl, text)
	if (debugLvl >= lvl and text) then
		debugPrint(text);
	end
end

function dverb(text)
	dlog(6, text);
end

function ddebug(text)
	dlog(5, text);
end

function dinfo(text)
	dlog(4, text);
end

function dwarn(text)
	dlog(3, text);
end

function derror(text)
	dlog(2, text);
end

function dfatal(text)
	dlog(1, text);
end
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Libraries
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
deployRequire();

utf8 = require('utf8');

function utf8.sub(s,i,j)
    return utf8.char(utf8.codepoint(s, i, j))
end
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Text typer for dialogue boxes
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
local textTyper = {
	timer = 0,
	text = '',
	sound = nil,
	interval = 0.05,
	pos = 0,
	finished = true,
	onType = nil
};

function textTyper.reset(self)
	dverb('reset()');
	self.pos = 0;
	self.timer = 0;
	self.text = '';
	self.finished = false;
	for i = 1,3,1 do
		setTextString('txtDiagText'..i, '');
	end
end

function textTyper.loadTxt(self, text, sound, interval, onType)
	interval = interval or 0.05;
	ddebug('loadTxt("'..text:replace('\n', ' ')..'", '..interval..')');
	self:reset();
	self.text = text;
	self.sound = nil;
	if (sound) then --Only if a sound was assigned
		if (fileExists('sounds/'..sound..'.ogg')) then --Ensure the requested sound exists
			self.sound = sound;
		else --Or fallback, otherwise the game will crash
			local tsound = diag.skin.data.sounds['talk'];
			if (tsound:len() == 0) then
				--Nothing
			elseif (fileExists('sounds/'..tsound..'.ogg')) then
				self.sound = tsound; --Custom
			else
				self.sound = 'dialogue'; --Stock
			end
		end
	end
	self.interval = interval;
	self.onType = onType;
	if (interval == 0) then
		self.interval = 0.05;
		self:skip();
	end
end

function textTyper.skip(self)
	self.pos = string.len(self.text) - 1;
	self.timer = (self.pos + 1) * self.interval - 0.01;
end

function textTyper.update(self, elapsed)
	if (self.finished) then
		return;
	end
	--dinfo(self.timer);
	self.timer = self.timer + elapsed;
	local nextTick = (self.pos + 1) * self.interval;
	local utf8len = string.len(self.text);
	--dinfo(nextTick..' - '..self.text);
	if (self.timer < nextTick or self.pos == utf8len) then
		return;
	end
	self.pos = self.pos + 1;
	--dinfo(tostring(self.timer)..' - '..self.pos);
	--Update text
	local msgLines = string.split(utf8.sub(self.text, 1, self.pos), '\n', true);
	for i = 1,3,1 do
		local line = msgLines[i];
		if (line) then
			setTextString('txtDiagText'..i, line);
			setProperty('txtDiagText'..i..'.visible', true);
		else
			setTextString('txtDiagText'..i, '');
			setProperty('txtDiagText'..i..'.visible', false);
		end
	end
	if (not isAny(utf8.sub(self.text, self.pos, self.pos), ' ', '\n')) then
		if (self.sound) then
			playSound(self.sound, 1, 'sfx:textType');
		end
		if (self.onType) then
			self.onType(self.pos);
		end
	end
	if (self.pos == utf8len) then
		setProperty('btnNext.visible', true);
		self.finished = true;
		--dverb(tostring(utf8.len(self.text))..', '..tostring(string.len(self.text))..', "'..utf8.sub(self.text, 1, self.pos)..'"');
	end
end
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Property map
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
local propBundle = {};

function propBundle.readValue(line, i)
	if (line:sub(i, i+3) == 'null') then
		return i+3, nil;
	end
	i = i + 1;
	local slen = line:len();
	local escape = false;
	local builder = {};
	for p = i, slen, 1 do
		local cs = line:sub(p, p);
		i = p;
		if (not escape and cs == '"') then
			break;
		elseif (not escape and cs == '\\') then
			escape = true;
		elseif (escape and cs == 'n') then
			table.insert(builder, '\n');
			escape = false;
		elseif (escape and cs == 't') then
			table.insert(builder, '\t');
			escape = false;
		elseif (escape and cs == 'f') then
			table.insert(builder, '\f');
			escape = false;
		else
			table.insert(builder, cs);
			escape = false;
		end
	end
	return i, table.concat(builder, '');
end

function propBundle.from(line)
	local space = line:indexOf(" ");
	if ((not line:startsWith("@")) or (space and space <= 2)) then
		return nil;
	end
	local prop = {};
	local start = space or line:len()+1;
	local slen = line:len();
	prop._type = line:sub(2, start-1);
	start = start + 1;
	local fase = 1;
	local field, value;
	--for i = start, slen, 1 do --You can't skip ahead on this thing smh
	local i = start;
	while (i <= slen) do
		if (fase == 1) then --field
			local idx = line:indexOf('=', i);
			if (idx) then
				field = line:sub(i, idx-1):trim();
				--dverb('"'..field..'" ['..i..', '..(idx-1)..']');
				i = idx;
				fase = 2;
			else
				break;
			end
		elseif (fase == 2) then --value
			i, value = propBundle.readValue(line, i);
			if (value) then
				prop[field] = value;
				--dverb('"'..field..'" = '..value);
			end
			fase = 1;
		end
		i = i+1;
	end
	--dverb('@'..prop._type..' '..tostring(prop.text));
	return prop;
end
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Dialogue module
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
diag = { --global
	ready = false,
	loaded = {},
	diagData = {},
	ctrlLock = false,
	nextLock = false,
	onDisplay = {},
	skinName = nil,
	skin = { name = nil, data = nil, defData = nil }
}

function diag.init(self)
	self:setSkin('default');
	diag.onDisplay.bgLayer = { 0, 0 };
	self.onDisplay.HUD = true;
end

function diag.applyBackground(self, entry, show)
	local prevlayer = self.onDisplay.bgLayer[2];
	local nextlayer = prevlayer + 1;
	local name = 'diagWall'..nextlayer;
	if (self.ready) then
		removeLuaSprite(name, true);
		self:stopBgMovement();
	end
	if (entry.src) then
		makeLuaSprite(name, entry.src, entry.pos[1], entry.pos[2]);
		scaleObject(name, entry.scale[1], entry.scale[2]);
	else
		makeLuaSprite(name, 'ds/dialogue/spacer', -10, -10);
		makeGraphic(name, 1300, 740, entry.color);
		scaleObject(name, 1, 1);
	end
	setProperty(name..'.alpha', 0);
	addLuaSprite(name, false);
	setObjectCamera(name, 'other');
	setObjectOrder(name, getObjectOrder('bgbmrk'));
	if (show and entry.transition) then
		if (entry.transition == 'crossfade') then
			local stime = strToTime(entry.time);
			doTweenAlpha('dwallFadeIn_'..nextlayer, name, 1, stime, 'linear');
			runTimer('diag:removeBg_'..prevlayer, stime);
		elseif (entry.transition == 'colorfade') then
			local stime = strToTime(entry.time);
			makeLuaSprite('fadeWall', 'ds/dialogue/skins/default/dbox_normal', -10, -10);
			makeGraphic('fadeWall', 1300, 740, entry.color);
			scaleObject('fadeWall', 1, 1);
			setProperty('fadeWall.alpha', 0);
			addLuaSprite('fadeWall', false);
			setObjectCamera('fadeWall', 'other');
			setObjectOrder('fadeWall', getObjectOrder('bgbmrk'));
			doTweenAlpha('fwallFadeIn_'..nextlayer..'_'..stime, 'fadeWall', 1, stime/2, 'linear');
			runTimer('diag:removeBg_'..prevlayer, stime/2);
		elseif (entry.transition == 'shake') then
			local stime = strToTime(entry.time);
			local shaken = tonumber(entry.intensity) or 0.007;
			setProperty(name..'.alpha', 1);
			self:removeBg(prevlayer);
			cameraShake("other", shaken, stime);
			if (entry.flash) then
				cameraFlash("other", entry.flash, 0.5, false);
			end
		else --"none"
			setProperty(name..'.alpha', 1);
			self:removeBg(prevlayer);
		end
	end
	self.onDisplay.bgLayer[2] = nextlayer;
	ddebug('applyBackground("'..tostring(entry.src)..'",'..tostring(show)..') '..name..', '..getObjectOrder(name));
end

function diag.moveBackgound(self, entry)
	local layer = self.onDisplay.bgLayer[2];
	local name = 'diagWall'..layer;
	local stime = strToTime(entry.time);
	local ease = entry.ease or 'linear'
	--doTweenScale('dwallScale', name, entry.scale[1], entry.scale[2], stime, ease);
	self.onDisplay.bgMoving = true;
	doTweenX('dwallMoveX', name, entry.pos[1], stime, ease);
	doTweenY('dwallMoveY', name, entry.pos[2], stime, ease);
	doTweenX('dwallScaleX', name..'.scale', entry.scale[1], stime, ease);
	doTweenY('dwallScaleY', name..'.scale', entry.scale[2], stime, ease);
end

function diag.stopBgMovement(self)
	if (self.onDisplay.bgMoving) then
		self.onDisplay.bgMoving = false;
		cancelTween('dwallMoveX');
		cancelTween('dwallMoveY');
		cancelTween('dwallScaleX');
		cancelTween('dwallScaleY');
	end
end

function diag.removeBg(self, layer)
	removeLuaSprite('diagWall'..layer, true);
	self.onDisplay.bgLayer[1] = math.min(self.onDisplay.bgLayer[2], math.max(layer + 1, self.onDisplay.bgLayer[1]));
	ddebug('removeBg("diagWall'..layer..'",'..tostring(layer)..') '..tostring(self.onDisplay.bgLayer[1]));
end

function diag.clearBg(self, immediately)
	local firstlayer = self.onDisplay.bgLayer[1];
	local lastlayer = self.onDisplay.bgLayer[2];
	if (lastlayer == 0) then
		return;
	end
	self:stopBgMovement();
	if (immediately) then
		for i = firstlayer,lastlayer,1 do
			self:removeBg(i);
		end
	else
		for i = firstlayer,lastlayer,1 do
			doTweenAlpha('dwallFadeOut_'..i, 'diagWall'..i, 0, 1, 'linear');
			ddebug('dwallFadeOut("diagWall'..i..'")');
		end
	end
end

local btnNextY = 635;

function diag.initComps(self)
	if (diag.ready) then
		return;
	end
	
	try(function()
		makeLuaSprite('bgbmrk', '', 0, 768);
		scaleObject('bgbmrk', 1, 1);
		addLuaSprite('bgbmrk', false);
		setObjectCamera('bgbmrk', 'other');
		
		local entry = self.skin.data['background'];
		self:applyBackground(entry, false);
		
		makeLuaSprite('boxbmrk', '', 0, 768);
		scaleObject('boxbmrk', 1, 1);
		addLuaSprite('boxbmrk', false);
		setObjectCamera('boxbmrk', 'other');
		
		local entry = self.skin.data['bgName'];
		makeLuaSprite('bgName', entry.src, entry.posL[1], entry.posL[2]); --L: 160, R: 790 ; 415
		scaleObject('bgName', entry.scale[1], entry.scale[2]);
		addLuaSprite('bgName', false);
		setObjectCamera('bgName', 'other');
		setProperty('bgName.visible', false);
		
		entry = self.skin.data['lblName'];
		makeLuaText('lblName', 'Character name', entry.width, entry.posL[1], entry.posL[2]); --350; L: 150, R: 780 ; 434
		setTextFont('lblName', entry.font);
		setTextSize('lblName', entry.fontSize);
		--setTextAlignment('lblName', entry.textAlign);
		setTextColor('lblName', entry.color);
		setTextBorder('lblName', 2, entry.border);
		--setTextItalic('lblName', true);
		setProperty('lblName.antialiasing', true);
		addLuaText('lblName');
		setObjectCamera('lblName', 'other');
		setProperty('lblName.visible', false);
		
		entry = self.skin.data['txtDiagText'];
		for i = 1,3,1 do
			makeLuaText('txtDiagText'..i, 'Message cöntént '..i..' with a quite long line asdf.', entry.width, entry.pos[1], entry.pos[2] + ((i-1) * entry.lineHeight));
			setTextFont('txtDiagText'..i, entry.font);
			setTextSize('txtDiagText'..i, entry.fontSize);
			setTextAlignment('txtDiagText'..i, entry.textAlign);
			setTextColor('txtDiagText'..i, entry.color);
			setTextBorder('txtDiagText'..i, 2, entry.border);
			--setTextItalic('lblName', true);
			setProperty('txtDiagText'..i..'.antialiasing', true);
			addLuaText('txtDiagText'..i);
			setObjectCamera('txtDiagText'..i, 'other');
			setProperty('txtDiagText'..i..'.visible', false);
		end
		
		entry = self.skin.data['btnNext'];
		btnNextY = entry.pos[2];
		makeLuaSprite('btnNext', entry.src, entry.pos[1], entry.pos[2]);
		scaleObject('btnNext', entry.scale[1], entry.scale[2]);
		addLuaSprite('btnNext', false);
		setObjectCamera('btnNext', 'other');
		setProperty('btnNext.visible', false);
		doTweenY('btnNextUp', 'btnNext', btnNextY - 3, 1, 'sineInOut');
		
		entry = self.skin.data['btnSkip'];
		makeLuaSprite('btnSkip', entry.src, 1290, entry.pos[2]); --1290, 30 --978, 30
		scaleObject('btnSkip', entry.scale[1], entry.scale[2]);
		addLuaSprite('btnSkip', false);
		setObjectCamera('btnSkip', 'other');
		setProperty('btnSkip.visible', false);
	end).logErrors().doIt();
	
	--[[makeLuaSprite('diagWall', 'ds/dialogue/skins/default/dbox_normal', -10, -10);
	makeGraphic('diagWall', 1300, 740, 'DDEEEE');
	scaleObject('diagWall', 1, 1);
	setProperty('diagWall.alpha', 0);
	addLuaSprite('diagWall', false);
	setObjectCamera('diagWall', 'other');
	
	makeLuaSprite('boxbmrk', '', 0, 768);
	scaleObject('boxbmrk', 1, 1);
	addLuaSprite('boxbmrk', false);
	setObjectCamera('boxbmrk', 'other');
	
	makeLuaSprite('bgName', 'ds/dialogue/skins/default/lbl_name', 160, 415); --L: 160, R: 790
	scaleObject('bgName', 1.5, 1.5);
	addLuaSprite('bgName', false);
	setObjectCamera('bgName', 'other');
	setProperty('bgName.visible', false);
	
	makeLuaText('lblName', 'Character name', 350, 150, 434); --L: 150, R: 780
	setTextFont('lblName', 'Gotham-Medium.ttf');
	setTextSize('lblName', 34);
	setTextAlignment('lblName', 'center');
	--setTextColor('lblName', 'FFFFFF');
	--setTextBorder('lblName', 2, '000000');
	--setTextItalic('lblName', true);
	setProperty('lblName.antialiasing', true);
	addLuaText('lblName');
	setObjectCamera('lblName', 'other');
	setProperty('lblName.visible', false);
	
	for i = 1,3,1 do
		makeLuaText('txtDiagText'..i, 'Message cöntént '..i..' with a quite long line asdf.', 930, 175, 452 + (i * 50));
		setTextFont('txtDiagText'..i, 'Gotham-Medium.ttf');
		setTextSize('txtDiagText'..i, 40);
		setTextAlignment('txtDiagText'..i, 'left');
		setTextColor('txtDiagText'..i, '000000');
		setTextBorder('txtDiagText'..i, 2, 'FFFFFF');
		--setTextItalic('lblName', true);
		setProperty('txtDiagText'..i..'.antialiasing', true);
		addLuaText('txtDiagText'..i);
		setObjectCamera('txtDiagText'..i, 'other');
		setProperty('txtDiagText'..i..'.visible', false);
	end
	
	makeLuaSprite('btnNext', 'ds/dialogue/skins/default/btn_next', 1055, btnNextY);
	scaleObject('btnNext', 1.5, 1.5);
	addLuaSprite('btnNext', false);
	setObjectCamera('btnNext', 'other');
	setProperty('btnNext.visible', false);
	doTweenY('btnNextUp', 'btnNext', btnNextY - 3, 1, 'sineInOut');
	
	makeLuaSprite('btnSkip', 'ds/dialogue/btn_skip', 1290, 30); --978, 30
	scaleObject('btnSkip', 1, 1);
	addLuaSprite('btnSkip', false);
	setObjectCamera('btnSkip', 'other');
	setProperty('btnSkip.visible', false);]]--
	
	diag.ready = true;
end

function diag.setSkin(self, name)
	if (self.skinName == name) then
		return;
	end
	if (self:loadSkin(name)) then
		if (self.ready) then
			--removeLuaSprite('diagWall', true);
			self:clearBg(true);
			removeLuaSprite('boxbmrk', true);
			removeLuaSprite('portaitL', true);
			removeLuaSprite('portaitR', true);
			removeLuaSprite('dbox', true);
			removeLuaSprite('bgName', true);
			removeLuaSprite('lblName', true);
			for i = 1,3,1 do
				removeLuaSprite('txtDiagText'..i, true);
			end
			removeLuaSprite('btnNext', true);
			removeLuaSprite('btnSkip', true);
			self.ready = false;
		end
		triggerEvent('dialogue.skinChanged', name, self.skinName);
		self.skinName = name;
	end
end

function diag.loadSkin(self, name)
	function clone(t)
	  local u = { }
	  for k, v in pairs(t) do u[k] = v end
	  return u;--setmetatable(u, getmetatable(t))
	end

	local target = 'images/ds/dialogue/skins/'..name..'/layout.txt';
	local textData;
	try(function() textData = readLines(target); end).logErrors().doIt();
	if not (textData and #textData > 0) then
		return false;
	end
	dverb('Data loaded: ' .. textData[1]);
	local layout = {};
	if (self.skin.defData) then
		layout = clone(self.skin.defData);
	end
	for i, line in ipairs(textData) do
		try(function()
			line = line:trim();
			if (line:len() == 0 or line:startsWith('--')) then
				--dwarn(line);
				return; --continue;
			elseif (line:startsWith('@')) then
				--dwarn(line);
				local prop = propBundle.from(line);
				if (not prop) then
					return; --continue;
				end
				local entry = (name == 'default') and {} or clone(layout[prop._type]);
				for key, value in pairs(prop) do
					--dwarn('['..key..'] = '..value);
					if (isAny(key, 'pos', 'posL', 'posR', 'scale')) then
						entry[key] = string.split(value, ',', true);
					else
						entry[key] = value;
					end
				end
				--table.insert(layout, entry);
				layout[entry._type] = entry;
				--dwarn('@'..entry._type..' '..tostring(entry.src));
			end
		end).catch(function(ex)
			derror('Error: '..ex..'\n- at line: '..line);
		end).doIt();
	end
	if (name == 'default') then
		self.skin.defData = layout;
	end
	self.skin.data = layout;
	ddebug('Dialogue skin loaded');
	return true;
end

function readDialogueLines(name)
	local langSufx = '.'..getLangCode();
	local targets = {
		'data/'..songName..'/'..name..langSufx..'.txt',
		'data/'..songName..'/'..name..'.txt'
	};
	local textData;
	for _, target in ipairs(targets) do
		ddebug('Loading "'..target..'"');
		local success, retval = pcall(function()
			textData = readLines(target);
		end);
		if (success and textData and #textData > 0) then
			return textData;
		else
			if (not success or not textData) then
				ddebug('File unreachable or unexistent');
				--derror('Error loading data: ' .. retval);
			else
				ddebug('File seems to be empty');
			end
		end
	end
	return nil;
end

function _newDiagEntry()
	local obj = {};
	obj['_type'] = nil;
	--Dialogue
	obj['pos'] = 'L';
	obj['alone'] = false;
	obj['portrait'] = 'bf';
	obj['state'] = 'default';
	obj['nameTag'] = nil;
	obj['text'] = '';
	obj['dbox'] = 'normal';
	obj['speed'] = 0.05;
	obj['voclip'] = nil;
	--Wait
	obj['time'] = 0;
	--Play Sound
	obj['src'] = nil;
	obj['vol'] = 1;
	--Event
	obj['values'] = {};
	--End
	obj['label'] = nil;
	--Background
	obj['transition'] = nil;
	obj['focused'] = false;
	return obj;
end

function diag.loadDialogue(self, name)
	local textData = readDialogueLines(name);
	if (not textData) then
		return false;
	end
	dverb('Data loaded: ' .. textData[1]);
	local dialogueSet = {};
	local branchData, branchLvl = {}, 0;
	local activeBlock = true;
	for i, line in ipairs(textData) do
		try(function()
			line = line:trim();
			if (line:len() == 0 or line:startsWith('--')) then
				--dwarn(line);
				return; --continue;
			--Legacy/simple format
			elseif (activeBlock and (line:startsWith('L') or line:startsWith('R'))) then
				local entry = _newDiagEntry();
				entry._type = 'dialogue';
				local data = string.split(line, '|', true);
				entry['pos'] = string.sub(data[1], 1, 1);
				if (string.len(data[1]) > 1) then
					--dinfo(data[1]..' - '..tostring(string.sub(data[1], 2, 2) == '-'));
					entry['alone'] = (string.sub(data[1], 2, 2) == '-');
				end
				local charbits = string.split(data[2], ':', true);
				entry['portrait'] = charbits[1];
				if (#charbits > 1) then
					entry['state'] = charbits[2];
				end
				entry['nameTag'] = data[3];
				entry['text'] = data[4]:replace('\\n','\n');
				if (#data > 4) then
					entry['dbox'] = data[5];
				end
				if (#data > 5) then
					entry['speed'] = tonumber(data[6]);
				end
				table.insert(dialogueSet, entry);
			--New format
			elseif (activeBlock and line:startsWith('@')) then
				--dwarn(line);
				local entry = _newDiagEntry();
				if (line:startsWith('@event')) then
					local pos, value = 8, '';
					local values = {};
					try(function()
						for i = 1,3 do
							pos, value = propBundle.readValue(line, pos);
							table.insert(values, value);
							pos = pos + 2;
						end
					end).doIt();
					entry._type = 'event';
					entry.values = values;
				elseif (line:startsWith('@endDialogue')) then
					entry._type = 'endDialogue';
					local pos = 14;
					try(function()
						pos, entry.label = propBundle.readValue(line, pos);
					end).doIt();
				elseif (line:startsWith('@bgChange') or line:startsWith('@bgMove')) then
					local prop = propBundle.from(line);
					if (not prop) then
						return; --continue;
					end
					for key, value in pairs(prop) do
						--dwarn('['..key..'] = '..value);
						if (isAny(key, 'pos', 'posL', 'posR', 'scale')) then
							entry[key] = string.split(value, ',', true);
						else
							entry[key] = value;
						end
					end
				elseif (line:startsWith('@dialogue')) then
					local prop = propBundle.from(line);
					if (not prop) then
						return; --continue;
					end
					for key, value in pairs(prop) do
						--dwarn('['..key..'] = '..value);
						entry[key] = value;
					end
					local str = entry['pos'];
					entry['pos'] = string.sub(str, 1, 1);
					if (string.len(str) > 1) then
						--dinfo(str..' - '..tostring(string.sub(str, 2, 2) == '-'));
						entry['alone'] = (string.sub(str, 2, 2) == '-');
					end
					local charbits = string.split(entry['portrait'], ':', true);
					entry['portrait'] = charbits[1];
					if (#charbits > 1) then
						entry['state'] = charbits[2];
					end
				else
					local prop = propBundle.from(line);
					if (not prop) then
						return; --continue;
					end
					for key, value in pairs(prop) do
						--dwarn('['..key..'] = '..value);
						entry[key] = value;
					end
				end
				table.insert(dialogueSet, entry);
				--dwarn('@'..entry._type..' '..tostring(entry.text));
			--Flow control
			elseif (line:startsWith('#')) then
				--Conditional branches
				if (line:startsWith('#if')) then
					local branch = {
						fired = false
					}
					local _, condition = propBundle.readValue(line, 5);
					dverb('IF condition: '..condition);
					pcall(function() branch.fired = loadstring('return '..condition)(); end);
					branchLvl = branchLvl + 1;
					branchData[branchLvl] = branch;
					activeBlock = branch.fired;
				elseif (branchLvl > 0 and line:startsWith('#else if')) then
					local branch = branchData[branchLvl];
					if (branch.fired) then
						activeBlock = false;
					else
						local condition = propBundle.readValue(line, 10);
						dverb('ELSE-IF condition: '..condition);
						pcall(function() branch.fired = loadstring('return '..condition)(); end);
						activeBlock = branch.fired;
					end
				elseif (branchLvl > 0 and line:startsWith('#else')) then
					local branch = branchData[branchLvl];
					activeBlock = not branch.fired;
				elseif (branchLvl > 0 and line:startsWith('#end')) then
					activeBlock = true;
					branchLvl = branchLvl - 1;
				end
			end
		end).catch(function(ex)
			derror('Error: '..ex..'\n- at line: '..line);
		end).doIt();
	end
	self.loaded[name] = dialogueSet;
	triggerEvent('dialogue.loaded', name, #dialogueSet);
	ddebug('Dialogue loaded');
	return true;
end

function diag.startDialogue(self, name, music)
	music = music or '';
	if (string.len(music) == 0) then
		music = nil;
	end
	local dialogue = self.loaded[name];
	if (not dialogue) then
		if (self:loadDialogue(name)) then
			dialogue = self.loaded[name];
		else
			derror('Could not load dialogue "'..name..'"');
			self:endDialogue(false);
			triggerEvent('dialogue.failed', name);
			return;
		end
	end
	setTextString('lblName', '');
	for i = 1,3,1 do
		setTextString('txtDiagText'..i, '');
	end
	self.onDisplay.music = music;
	if (music) then
		playMusic(music, 0, true);
		soundFadeIn('', 2, 0, 1);
	end
	--diag.onDisplay.bgLayer = { 0, 0 };
	--local entry = self.skin.data['background'];
	--self:applyBackground(entry, false);
	triggerEvent('dialogue.started', name);
	self:showPage(name, 1);
end

function diag.showPanels(self)
	if (self.onDisplay.HUD) then
		setProperty('bgName.visible', true);
		setProperty('lblName.visible', true);
		setProperty('portraitL.visible', true);
		setProperty('portraitR.visible', true);
		setProperty('dbox.visible', true);
		setProperty('btnNext.visible', true);
		for i = 1,3,1 do
			setProperty('txtDiagText'..i..'.visible', true);
		end
	end
end

function diag.hidePanels(self)
	setProperty('bgName.visible', false);
	setProperty('lblName.visible', false);
	setProperty('portraitL.visible', false);
	setProperty('portraitR.visible', false);
	setProperty('dbox.visible', false);
	setProperty('btnNext.visible', false);
	for i = 1,3,1 do
		setProperty('txtDiagText'..i..'.visible', false);
	end
end

function diag.endDialogue(self, notify)
	if (self.onDisplay.music) then
		soundFadeOut('', 0.9);
	end
	if (self.onDisplay.diagName) then
		diag:clearBg(false);
		textTyper:reset();
		doTweenX('bskipSlideOut', 'btnSkip', 1290, 0.15, 'expIn');
		setProperty('bgName.visible', false);
		setProperty('lblName.visible', false);
		removeLuaSprite('portraitL', true);
		removeLuaSprite('portraitR', true);
		removeLuaSprite('dbox', true);
		setProperty('btnNext.visible', false);
		for i = 1,3,1 do
			setProperty('txtDiagText'..i..'.visible', false);
		end
		--cancelTween('dwallFadeIn');
		cancelTween('bskipSlideIn');
		cancelTimer('diag:wait');
		local entry = self.skin.data['background'];
		self:applyBackground(entry, false);
	end
	if (notify) then
		triggerEvent('dialogue.ended', self.onDisplay.diagName, self.onDisplay.endLabel or '');
	end
	self.onDisplay.diagName = nil;
	self.onDisplay.endLabel = nil;
	diag.onDisplay.prev = nil;
	diag.onDisplay.charL = nil;
	diag.onDisplay.charR = nil;
	diag.onDisplay.stateL = nil;
	diag.onDisplay.staterR = nil;
	diag.onDisplay.boxStyle = nil;
	self.onDisplay.curPage = 0;
	--diag.onDisplay.bgLayer = { 0, 0 };
	setPropertyFromClass('flixel.FlxG', 'mouse.visible', false);
	runTimer('dialogueExit', 1);
end

function diag.showPage(self, name, page)
	ddebug(name..' p'..tostring(page));
	self:initComps();
	local dialogue = self.loaded[name];
	if (not dialogue or page > #dialogue) then
		self:endDialogue(true);
		return;
	end
	if (not self.onDisplay.diagName) then
		self.onDisplay.HUD = true;
		local layer = self.onDisplay.bgLayer[2];
		if (self.skin.data['background'].src) then
			doTweenAlpha('dwallFadeIn_'..layer, 'diagWall'..layer, 1, 1, 'linear');
			dinfo('dwallFadeIn("diagWall'..layer..'","'..tostring(self.skin.data['background'].src)..'")');
		else
			doTweenAlpha('dwallFadeIn_'..layer, 'diagWall'..layer, 9/16, 3, 'linear');
		end
		setProperty('btnSkip.visible', true);
		local px = self.skin.data['btnSkip'].pos[1];
		doTweenX('bskipSlideIn', 'btnSkip', px, 0.15, 'expOut');
		setProperty('bgName.visible', false);
		setProperty('lblName.visible', false);
		setProperty('btnNext.visible', false);
		--Capture control from the player (no pause menu and stuff)
		setProperty('canPause', false);
		setProperty('camZooming', false);
		setProperty('inCutscene', true);
	end
	self.onDisplay.diagName = name;
	local prev = diag.onDisplay.prev or _newDiagEntry(); --dialogue[page - 1]
	local curr = dialogue[page];
	triggerEvent('dialogue.step', name, tostring(page));
	if (curr['_type'] == 'dialogue') then
		local pos = curr['pos'];
		local opos = pos == 'L' and 'R' or 'L';
		
		function refreshPortrait(jump)
			local tag = 'portrait'..pos;
			local entry = self.skin.data['portrait'];
			--[[local px, pt = 30, 80;
			if (pos == 'R') then
				px, pt = 770, 720;
			end]]--
			local cx = entry['pos'..pos][1];
			local px, pt;
			if (pos == 'L') then
				px, pt = cx - entry.slide, cx;
			else
				px, pt = cx + entry.slide, cx;
			end
			--Change the spritesheet of the active portrait for a new one
			if (self.onDisplay['char'..pos] ~= curr['portrait']) then
				makeAnimatedLuaSprite(tag, 'dialogue/'..curr['portrait'], px, entry['pos'..pos][2]); -- L: 80, R: 720
				addAnimationByPrefix(tag, curr['state'], curr['state']..'0', 24, false); --curr['portrait']..'-'..curr['state']
				dverb(curr['portrait']..'-'..curr['state']);
				objectPlayAnimation(tag, curr['state'], false);
				scaleObject(tag, entry.scale[1], entry.scale[2]);
				setProperty(tag..'.flipX', (pos == 'R'));
				addLuaSprite(tag, false);
				setObjectCamera(tag, 'other');
				setObjectOrder(tag, getObjectOrder('boxbmrk'));
				setProperty(tag..'.alpha', 0);
				doTweenAlpha('portraitFadeInC_'..pos, tag, 1, 0.15, 'sineOut');
				doTweenX('portraitFadeInX_'..pos , tag, pt, 0.15, 'sineOut');
			--Change only the animation of the active portrait
			elseif (self.onDisplay['state'..pos] ~= curr['state']) then
				addAnimationByPrefix(tag, curr['state'],  curr['state']..'0', 24, false); --curr['portrait']..'-'..curr['state']
				dverb(curr['portrait']..'-'..curr['state']);
				objectPlayAnimation(tag, curr['state'], false);
				if (jump) then
					doTweenY('portraitJump_'..pos, tag, entry['pos'..pos][2]-5, 0.1, 'sineOut');
				end
			end
			--Otherwise the portrait can remain the same
		end
		
		function fadeOutPortrait(tpos)
			local tag = 'portrait'..tpos;
			local entry = self.skin.data['portrait'];
			--[[local px, pt = 80, 130;
			if (tpos == 'R') then
				px, pt = 720, 670;
			end]]--
			local cx = entry['pos'..tpos][1];
			local px, pt;
			if (tpos == 'L') then
				px, pt = cx, cx + entry.slide, cx;
			else
				px, pt = cx, cx - entry.slide;
			end
			--dverb('portraitFadeOutX_'..tpos..' - '..tostring(px - 50));
			doTweenColor('portraitFadeOutC_'..tpos, tag, '0x00666666', 0.15, 'sineOut');
			doTweenX('portraitFadeOutX_'..tpos , tag, pt, 0.15, 'sineOut');
		end
		
		if (prev['pos'] == curr['pos']) then
			refreshPortrait(true);
			--Darken or hide the inactive portait if needed
			dverb('onDisplay["char'..opos..'"] - '..tostring(self.onDisplay['char'..opos]));
			if (self.onDisplay['char'..opos] and curr['alone']) then
				fadeOutPortrait(opos);
			end
		else
			local tag = 'portrait'..pos;
			local optag = 'portrait'..opos;
			local entry = self.skin.data['portrait'];
			refreshPortrait(false);
			--Lighten up the now active portrait
			if (self.onDisplay['char'..pos] == curr['portrait']) then
				doTweenColor('portrait'..pos..'Highl', tag, '0xFFFFFFFF', 0.15, 'sineOut');
				doTweenY('portrait'..pos..'Up', tag, entry['pos'..pos][2], 0.15, 'sineOut');
			end
			--Darken or hide the now inactive portait
			try(function()
				dverb('onDisplay["char'..opos..'"] - '..tostring(self.onDisplay['char'..opos]));
				if (self.onDisplay['char'..opos]) then
					cancelTween('portraitFall_'..opos);
					if (curr['alone']) then
						fadeOutPortrait(opos);
					else
						doTweenColor('portrait'..opos..'Darken', optag, '0xEE999999', 0.15, 'sineOut');
						doTweenY('portrait'..opos..'Down', optag, entry['pos'..opos][2]+20, 0.15, 'sineOut');
					end
				end
			end).catch(function(ex)
				derror('Error: ' .. retval);
			end).doIt();
		end
		
		--Refresh the nametag
		if (curr['nameTag']) then
			--[[local px = 160;
			if (pos == 'R') then
				px = 790;
			end]]--
			local pc = self.skin.data['bgName']['pos'..pos];
			setProperty('bgName.x', pc[1]); --L: 160, R: 790
			setProperty('bgName.y', pc[2]);
			setProperty('bgName.visible', true);
			pc = self.skin.data['lblName']['pos'..pos];
			setTextString('lblName', curr['nameTag']);
			setProperty('lblName.x', pc[1]); --L: 150, R: 780
			setProperty('lblName.y', pc[2]);
			local entry = self.skin.data['lblName'];
			if (entry.textAlign == 'auto') then
				setTextAlignment('lblName', pos == 'R' and 'right' or 'left');
			else
				setTextAlignment('lblName', entry.textAlign);
			end
			setProperty('lblName.visible', true);
		end
		
		--Update the dialogue globe if needed
		if (self.onDisplay.boxStyle ~= curr['dbox']) then
			if (self.onDisplay.boxStyle) then
				removeLuaSprite('dbox', true);
			end
			local entry = self.skin.data['dbox'];
			dverb(entry.pref..curr['dbox']);
			makeLuaSprite('dbox', entry.pref..curr['dbox'], entry.pos[1], entry.pos[2]);
			scaleObject('dbox', entry.scale[1], entry.scale[2]);
			addLuaSprite('dbox', false);
			setObjectCamera('dbox', 'other');
		end
		setObjectOrder('dbox', getObjectOrder('boxbmrk'));
		
		--Update text
		local sound = curr['voclip'];
		local onType = function(pos)
			--dwarn("Typed!");
			if (pos % 3 == 0) then
				objectPlayAnimation('portrait'..curr['pos'], curr['state'], true);
			end
		end
		if (sound and fileExists('sounds/'..sound..'.ogg')) then --Ensure VO clip exists
			textTyper:loadTxt(curr['text'], nil, tonumber(curr['speed']), onType);
			ddebug('Voice over: "'..sound..'"');
			playSound(sound, 1, 'sfx:voiceOver');
		else --Fallback to text sounds otherwise
			local sound = self.skin.data.sounds['talk'];
			if (sound:len() == 0) then
				textTyper:loadTxt(curr['text'], nil, tonumber(curr['speed']), onType); --Nothing
			else
				textTyper:loadTxt(curr['text'], 'dialogue/'..curr['portrait'], tonumber(curr['speed']), onType);
			end
		end
		setProperty('btnNext.visible', false);
		
		--Update tracking info
		self.onDisplay['char'..pos] = curr['portrait'];
		self.onDisplay['char'..pos..'.y'] = self.skin.data['portrait']['pos'..pos][2];
		self.onDisplay['state'..pos] = curr['state'];
		if (curr['alone']) then
			self.onDisplay['char'..opos] = nil;
			self.onDisplay['state'..opos] = nil;
		end
		self.onDisplay.boxStyle = curr['dbox'];
		diag.onDisplay.prev = curr; --Remember this bit of dialogue later
	elseif (isAny(curr['_type'], 'bgChange', 'bgMove')) then
		if (curr['_type'] == 'bgChange') then
			self:applyBackground(curr, true);
		else
			self:moveBackgound(curr);
		end
		if (curr.focused == 'true') then
			self.ctrlLock = true;
			diag:hidePanels();
			runTimer('diag:waitAndShow', strToTime(curr.time));
		else
			self:showPage(name, page + 1);
			return;
		end
	elseif (curr['_type'] == 'showPanels') then
		self.onDisplay.HUD = true;
		self:showPanels();
		self:showPage(name, page + 1);
		return;
	elseif (curr['_type'] == 'hidePanels') then
		self.onDisplay.HUD = false;
		self:hidePanels();
		self:showPage(name, page + 1);
		return;
	elseif (curr['_type'] == 'playSound') then
		ddebug('playSound "'..tostring(curr['src'])..'"');
		local sound = curr['src'];
		if (sound and fileExists('sounds/'..sound..'.ogg')) then
			local tag = curr['tag'] or 'playSound';
			playSound(sound, 1, 'sfx:'..tag);
		end
		self:showPage(name, page + 1);
		return;
	elseif (curr['_type'] == 'stopSound') then
		local tag = curr['tag'] or 'playSound';
		ddebug('stopSound "'..tag..'"');
		soundFadeOut('sfx:'..tag, 1.5);
		self:showPage(name, page + 1);
		return;
	elseif (curr['_type'] == 'wait') then
		ddebug('wait '..tostring(curr['time']));
		local stime = 0;
		if (not curr.time) then
			self:showPage(name, page + 1);
			return;
		end
		local skipFlk = true;
		try(function()
			stime = strToTime(curr.time);
			if (stime) then
				ddebug('Time: '..tostring(stime));
				self.nextLock = true;
				runTimer('diag:wait', stime);
				skipFlk = false;
			end
		end).catch(function(ex)
			derror('Incorrect time value "'..curr.time..'"');
		end).doIt();
		if (skipFlk) then
			self:showPage(name, page + 1);
			return;
		end
	elseif (curr['_type'] == 'event') then
		if (curr.values[1] and curr.values[1]:len() > 0) then
			triggerEvent(curr.values[1], curr.values[2] or '', curr.values[3] or '');
		end
		self:showPage(name, page + 1);
		return;
	elseif (curr['_type'] == 'endDialogue') then
		ddebug('endDialogue');
		self.onDisplay.endLabel = curr.label;
		self:endDialogue(true);
		return;
	end
	setPropertyFromClass('flixel.FlxG', 'mouse.visible', true);
	self.onDisplay.curPage = page;
end

function diag.update(self, elapsed)
	local mx, my, pressed = getMouseX('other'), getMouseY('other'), mouseClicked('left');
	if (self.onDisplay.diagName and not self.ctrlLock) then
		if (not self.nextLock and (isKeyPressed('SPACE') or isKeyPressed('Z') or isKeyPressed('X') or isKeyPressed('ENTER'))) then
			--dverb('Key pressed');
			if (not textTyper.finished) then
				textTyper:skip();
			else
				local success, retval = pcall(function()
					self.ctrlLock = true;
					runTimer('ctrlRelease', 0.18);
					self:showPage(self.onDisplay.diagName, self.onDisplay.curPage + 1);
					local sound = self.skin.data.sounds['next'];
					if (sound:len() == 0) then
						--Nothing
					elseif (fileExists('sounds/'..sound..'.ogg')) then
						playSound(sound, 1, 'sfx:dialogueStep');
					else
						playSound('dialogueClose', 1, 'sfx:dialogueStep');
					end
				end);
				if (not success) then
					derror('Error during page transition: ' .. retval);
					return false;
				end
			end
		end
		if (keyJustPressed('back') or (pressed and mouseOver('btnSkip', mx, my))) then
			--setProperty('diagWall.visible', false);
			triggerEvent('dialogue.skipped', self.onDisplay.diagName, self.onDisplay.curPage);
			self:endDialogue(false);
		end
	end
	if (self.onDisplay.diagName) then
		textTyper:update(elapsed);
		if (diag.onDisplay.bgMoving) then
			local layer = self.onDisplay.bgLayer[2];
			local name = 'diagWall'..layer;
			updateHitbox(name);
		end
	end
end
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- Event listeners
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function onCreate()
	diag:init();
end

function onCreatePost()
	--doTweenY('btnNextUp', 'btnNext', btnNextY - 3, 1, 'sineInOut');
end

function onTweenCompleted(tag) --doTweenAlpha('fwallFadeIn_'..nextlayer..'_'..stime, 'fadeWall', 1, stime/2, 'linear');
	if (tag == 'btnNextUp') then
		doTweenY('btnNextDown', 'btnNext', btnNextY + 3, 1, 'sineInOut');
	elseif (tag == 'btnNextDown') then
		doTweenY('btnNextUp', 'btnNext', btnNextY - 3, 1, 'sineInOut');
	elseif (tag == 'bskipSlideOut') then
		setProperty('btnSkip.visible', false);
	elseif (tag == 'dwallMoveX') then
		diag.onDisplay.bgMoving = false;
	elseif (string.startsWith(tag, 'fwallFadeIn_')) then
		local params = tag:split('_', true);
		local layer = tonumber(params[2]);
		local stime = tonumber(params[3]);
		--diag:removeBg(layer);
		setProperty('diagWall'..layer..'.alpha', 1);
		doTweenAlpha('fwallFadeOut_'..layer, 'fadeWall', 0, stime/2, 'linear');
	elseif (string.startsWith(tag, 'fwallFadeOut_')) then
		removeLuaSprite('fadeWall', true);
	elseif (string.startsWith(tag, 'dwallFadeOut_')) then
		local layer = tonumber(string.sub(tag, 14));
		diag:removeBg(layer);
	elseif (string.startsWith(tag, 'portraitJump_')) then
		local pos = string.sub(tag, 14, 14);
		doTweenY('portraitFall_'..pos, 'portrait'..pos, diag.onDisplay['char'..pos..'.y'], 0.6, 'elasticOut');
	elseif (string.startsWith(tag, 'portraitFadeOutX_')) then
		local pos = string.sub(tag, 18, 18);
		removeLuaSprite('portrait'..pos, true);
	end
end

function onTimerCompleted(tag)
    if tag == 'dialogueExit' then
		--Release control back to the player
		setProperty('canPause', true);
		setProperty('camZooming', true);
		setProperty('inCutscene', false);
		if (getProperty('endingSong')) then
			endSong();
		else
			startCountdown();
		end
	elseif (tag == 'diag:waitAndShow') then
		diag.ctrlLock = false;
		diag:showPanels();
		diag:showPage(diag.onDisplay.diagName, diag.onDisplay.curPage + 1);
	elseif (tag:startsWith('diag:wait')) then
		diag.nextLock = false;
		diag:showPage(diag.onDisplay.diagName, diag.onDisplay.curPage + 1);
	elseif (tag:startsWith('diag:removeBg')) then
		--runTimer('diag:removeBg_'..prevlayer, stime);
		local layer = tonumber(tag:sub(15));
		diag:removeBg(layer);
	elseif (tag == 'ctrlRelease') then
		diag.ctrlLock = false;
	end
end

function isKeyPressed(key)
	return getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..key);
end

function onUpdate(elapsed)
	--dverb(tostring(elapsed));
	diag:update(elapsed);
end

function onEvent(name, value1, value2)
	if (name == 'dialogue.setSkin') then
		diag:setSkin(value1);
	elseif (name == 'loadDialogue' or name == 'dialogue.load') then
		diag:loadDialogue(value1);
	elseif (name == 'startDialogue' or name == 'dialogue.start') then
		dverb('startDialogue("'..value1..'", "'..value2..'")');
		diag:startDialogue(value1, value2);
	end
end