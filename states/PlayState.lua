PlayState = Class{__includes = BaseState}

require 'classes/Player'
require 'classes/Bismarck'
require 'classes/Arado'

local isScrolling = true
local spawnTimer = 0
bullets = {}
local arados = {}
local lastAradoY = 0

function PlayState:init()
    player1 = Player(50, 100)
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
                    bullet.remove = true
                    arado.remove = true
                end
            end
            
        end

        for key, bullet in pairs(bullets) do
            if bullet.remove then
                table.remove(bullets, key)
            end
        end

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
end

function PlayState:exit() 
end