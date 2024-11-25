local speed = 5 -- Speed at which the arrows move

function onUpdate(elapsed)
    songPos = getSongPosition()
    local currentBeat = (songPos / 1000) * (curBpm / 60)

    -- Move arrows along the x-axis
    local maxWidth = 1280 -- Screen width (adjust as needed)
    for i = 0, 3 do
        -- Opponent notes moving left to right
        local xPosition = (defaultOpponentStrumX0 + (speed * currentBeat) + (i * 50)) % maxWidth
        setPropertyFromGroup('opponentStrums', i, 'x', xPosition)
    end

    for i = 4, 7 do
        -- Player notes moving right to left
        local xPosition = (defaultPlayerStrumX0 - (speed * currentBeat) - ((i - 4) * 50)) % maxWidth
        if xPosition < 0 then
            xPosition = xPosition + maxWidth
        end
        setPropertyFromGroup('playerStrums', i - 4, 'x', xPosition)
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
