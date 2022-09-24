local allowCountdown = false

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and not seenCutscene and isStoryMode then --
		--setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		seenCutscene = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		--debugPrint('OUT: onEvent("startDialogue", "dialogue", "breakfast")');
		triggerEvent('startDialogue', 'dialogue', '');
	end
end

function opponentNoteHit()
    health = getProperty('health')
    if getProperty('health') > 0.1 then
        setProperty('health', health- 0.02);
    end
end

local allowEnd = false;

function onEndSong()
	if not allowEnd and isStoryMode then --
		setProperty('inCutscene', true);
		allowEnd = true;
		triggerEvent('startDialogue', 'dialogue-end', '');
		return Function_Stop;
	end
	return Function_Continue;
end