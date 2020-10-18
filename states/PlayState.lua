PlayState = Class{__includes = BaseState}

require 'classes/UI'
require 'classes/Player'
require 'classes/Bismarck'
require 'classes/Arado'

local isScrolling = true
local spawnTimer = 0
bullets = {}
local arados = {}
local lastAradoY = 0
local score = 0

function PlayState:init()
    ui = UI()
    player1 = Player(50, 100)
    score = 0
    isScrolling = true
    spawnTimer = 0
    bullets = {}
    arados = {}
    lastAradoY = 0
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('title')
    end

    if isScrolling then
        if spawnTimer > 2 then
            table.insert(arados, Arado(lastAradoY))
            spawnTimer = 0
            lastAradoY = lastAradoY - 150 + math.random(300)        
            
            if lastAradoY < 0 then
                lastAradoY = math.random(300)
            elseif lastAradoY > VIRTUAL_PLAYAREA_HEIGHT then
                lastAradoY = math.random(VIRTUAL_PLAYAREA_HEIGHT - 300, VIRTUAL_PLAYAREA_HEIGHT)
            end
        end

        for key, arado in pairs(arados) do
            arado:update(dt)

            if player1:collides(arado) then
                isScrolling = false
                gStateMachine:change('gameover')
            end
        end

        for key, arado in pairs(arados) do
            if arado.remove then
                table.remove(arados, key)
            end
        end

        player1:update(dt)

        for key, bullet in pairs(bullets) do
            bullet:update(dt)
    
            
            for key, arado in pairs(arados) do
                if bullet:collides(arado) then
                    sounds['explosion']:stop()
                    sounds['explosion']:play()
                    bullet.remove = true
                    arado.remove = true
                    score = score + 50
                    ui:setScore(score)
                end
            end
            
        end

        for key, bullet in pairs(bullets) do
            if bullet.remove then
                table.remove(bullets, key)
            end
        end

        ui:setAltitude(500 - math.ceil(player1.y))

        spawnTimer = spawnTimer + dt        
    end
end

function PlayState:render()
    player1:render()
    for k, arado in pairs(arados) do
        arado:render()
    end

    for key, bullet in pairs(bullets) do
        bullet:render()
    end

    ui:render()
    -- displayScore()
end

function PlayState:exit() 
end

-- function displayScore()
--     love.graphics.setFont(gSmallFont)
--     love.graphics.setColor(200, 0, 0, 255)
--     love.graphics.print('Score: ' .. tostring(score), VIRTUAL_WIDTH - 100, 10)
-- end