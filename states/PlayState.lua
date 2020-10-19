PlayState = Class{__includes = BaseState}

require 'classes/UI'
require 'classes/Player'
require 'classes/Torpedo'
require 'classes/Bismarck'
require 'classes/Arado'

local isScrolling = true
local spawnTimer = 0
bullets = {}
local arados = {}
local lastAradoY = 0
local score = 0
local enemiesSpawned = 0
local bismarckIsStarted = false

function PlayState:init()
    ui = UI()
    player1 = Player(50, 100)
    torpedo = Torpedo(120, 139)
    bismarck = Bismarck(1050, VIRTUAL_HEIGHT - 375)
    score = 0
    isScrolling = true
    spawnTimer = 0
    bullets = {}
    arados = {}
    lastAradoY = 0
    enemiesSpawned = 0
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('title')
    end

    if enemiesSpawned == 10 then bismarckIsStarted = true end

    if bismarckIsStarted then
        bismarck:move(dt)
        if bismarck.isSinking then
            bismarck:sink(dt)
        end
    end

    if isScrolling then
        if spawnTimer > 2 then
            table.insert(arados, Arado(lastAradoY))
            enemiesSpawned = enemiesSpawned + 1
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

        if torpedo then torpedo:update(dt) end

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


        if torpedo and torpedo:collides(bismarck) then
            sounds['explosion']:stop()
            sounds['explosion']:play()
            bismarck.isSinking = true
            torpedo = null
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
    if torpedo then torpedo:render() end
    bismarck:render()
    player1:render()
    for k, arado in pairs(arados) do
        arado:render()
    end

    for key, bullet in pairs(bullets) do
        bullet:render()
    end

    ui:render()
end

function PlayState:exit() 
end