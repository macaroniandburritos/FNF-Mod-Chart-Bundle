local spacing = 150 -- Increase spacing to spread the arrows out more
local maxWidth = 1280 -- Screen width (adjust as needed)

-- Function to generate a random speed between 50 and 150
local function getRandomSpeed()
    return math.random(50, 150)
end

-- Initialize speeds for each arrow
local speeds = {}
for i = 1, 8 do
    table.insert(speeds, getRandomSpeed() * (math.random(0, 1) == 0 and 1 or -1)) -- Randomize direction as well
end

function onUpdate(elapsed)
    songPos = getSongPosition()
    local currentBeat = (songPos / 1000) * (curBpm / 60)

    -- Move arrows along the x-axis with random speeds and directions
    for i = 0, 3 do
        -- Opponent notes moving in different directions
        local speed = speeds[i + 1]
        local xPosition = (defaultOpponentStrumX0 + (speed * currentBeat) + (i * spacing)) % maxWidth
        if xPosition < 0 then
            xPosition = xPosition + maxWidth
        end
        setPropertyFromGroup('opponentStrums', i, 'x', xPosition)
    end

    for i = 4, 7 do
        -- Player notes moving in different directions
        local speed = speeds[i + 1]
        local xPosition = (defaultPlayerStrumX0 + (speed * currentBeat) + ((i - 4) * spacing)) % maxWidth
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
