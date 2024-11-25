local HudBop = true;
local fadeOutTime = 60 -- time in seconds to start fading back
local totalLoopTime = 120 -- total time for one complete wave cycle (in seconds)

function onUpdate(elapsed)
    songPos = getSongPosition()
    local currentBeat = (songPos / 5000) * (curBpm / 60)
    local loopProgress = (songPos / 1000) % totalLoopTime

    -- Wave movement with different speeds
    local yOffset = 100 -- Increase this value for a stronger wave effect
    local fadeStartBeat = fadeOutTime * (curBpm / 60) -- Calculate the beat to start fading out

    for i = 0, 3 do
        -- Opponent notes with varying speeds
        local speedMultiplier = 1 + i * 0.2 -- Increase speed variation
        local offsetY = yOffset * math.sin((currentBeat * speedMultiplier) * math.pi)
        if loopProgress >= fadeOutTime then
            local fadeProgress = (loopProgress - fadeOutTime) / (totalLoopTime - fadeOutTime)
            offsetY = offsetY * (1 - fadeProgress) -- Gradually reduce the offset to fade back
        end
        setPropertyFromGroup('opponentStrums', i, 'y', defaultOpponentStrumY0 + offsetY)
    end

    for i = 4, 7 do
        -- Player notes with varying speeds
        local speedMultiplier = 1 + (i - 4) * 0.2 -- Increase speed variation
        local offsetY = yOffset * math.sin((currentBeat * speedMultiplier) * math.pi)
        if loopProgress >= fadeOutTime then
            local fadeProgress = (loopProgress - fadeOutTime) / (totalLoopTime - fadeOutTime)
            offsetY = offsetY * (1 - fadeProgress) -- Gradually reduce the offset to fade back
        end
        setPropertyFromGroup('playerStrums', i - 4, 'y', defaultPlayerStrumY0 + offsetY)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    cameraShake(game, 0.0015, 0.15)
    setProperty('health', getProperty('health') - 1 * ((getProperty('health') / 22)) / 6)
    doTweenZoom('camerazoom', 'camGame', 0.775, 0.15, 'quadInOut')
    cameraSetTarget('dad')
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    cameraShake(game, 0.0015, 0.15)
    doTweenZoom('camerazoom', 'camGame', 0.725, 0.15, 'quadInOut')
    cameraSetTarget('boyfriend')
end
