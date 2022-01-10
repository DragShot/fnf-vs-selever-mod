function onCreate()
	--Background stuff
	makeLuaSprite('back','stages/iglesia/bg',-550, -1030);
	addLuaSprite('back',false);
	scaleObject('back', 1.35, 1.35);
	setLuaSpriteScrollFactor('back', 1, 1);
	--Effect stuff
	makeLuaSprite('blammedLightsBlack','stages/iglesia/blackwall',-640, -360);
	addLuaSprite('blammedLightsBlack',false);
	setBlendMode('blammedLightsBlack','multiply');
	--doTweenAlpha('bwAlpha','blammedLightsBlack',0,0.1,'linear');
	--Do not call back to any event listeners
	close(true);
end

function onUpdate(elapsed)

end

function onBeatHit( ... )--for every beat
	-- body
end

function onStepHit( ... )-- for every step
	-- body
end

function onUpdate( ... )
    -- body
end




function onBeatHit( ... )--for every beat
	-- body
end

function onStepHit( ... )-- for every step
	-- body
end

function onUpdate( ... )
    -- body
end
