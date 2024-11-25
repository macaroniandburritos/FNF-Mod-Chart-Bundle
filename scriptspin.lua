local Camthing = 1;
local CamThingy = 1;

function onUpdate(elapsed)
    songPos = getSongPosition()
    local currentBeat = (songPos / 1000) * (curBpm / 60)

    -- Circular movement and spinning
    local radius = 100
    local angleIncrement = (2 * math.pi) / 8 -- 8 notes in total

    for i = 0, 3 do
        -- Opponent notes circular movement and spinning
        local angle = currentBeat + i * angleIncrement
        local offsetX = radius * math.cos(angle)
        local offsetY = radius * math.sin(angle)
        setPropertyFromGroup('opponentStrums', i, 'x', defaultOpponentStrumX0 + offsetX)
        setPropertyFromGroup('opponentStrums', i, 'y', defaultOpponentStrumY0 + offsetY)
    end

    for i = 4, 7 do
        -- Player notes circular movement and spinning
        local angle = currentBeat + (i - 4) * angleIncrement
        local offsetX = radius * math.cos(angle)
        local offsetY = radius * math.sin(angle)
        setPropertyFromGroup('playerStrums', i - 4, 'x', defaultPlayerStrumX0 + offsetX)
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
