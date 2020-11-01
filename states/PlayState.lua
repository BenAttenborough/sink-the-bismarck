PlayState = Class{__includes = BaseState}

require 'classes/UI'
require 'classes/Player'
require 'classes/Torpedo'
require 'classes/Bismarck'
require 'classes/Arado'
require 'classes/Ocean'

local isScrolling = true
local spawnTimer = 0
bullets = {}
local arados = {}
local lastAradoY = 0
local score = 0
local enemiesSpawned = 0
local bismarckIsStarted = false
local sea_top = love.graphics.newImage('graphics/sea_top.png')
local sea_bottom = love.graphics.newImage('graphics/sea_bottom.png')

function PlayState:enter(params)
    -- self.player1.x = params.playerX
    -- self.player1.y = params.playerY
    ui = UI()
    player1 = Player(params.playerX, params.playerY)
    torpedo = Torpedo(params.playerX + 70, params.playerY + 39)
    bismarck = Bismarck(1050, VIRTUAL_HEIGHT - 375)
    ocean = Ocean()
    score = 0
    isScrolling = true
    spawnTimer = 0
    bullets = {}
    arados = {}
    lastAradoY = 0
    enemiesSpawned = 0
    player1:spinProp()
    aradoAdditonalSpeed = 0
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('title')
    end

    topSeaScroll = (topSeaScroll + TOP_SEA_SCROLL_SPEED * dt) 
        % GROUND_LOOPING_POINT
    
    bottomSeaScroll = (bottomSeaScroll + BOTTOM_SEA_SCROLL_SPEED * dt) 
        % GROUND_LOOPING_POINT

    if enemiesSpawned == 2 then bismarckIsStarted = true end

    if bismarckIsStarted then
        bismarck:move(dt)
        if bismarck.isSinking then
            bismarck:sink(dt)
        end
    end

    if isScrolling then
        if spawnTimer > 2 then
            table.insert(arados, Arado(lastAradoY, aradoAdditonalSpeed))
            enemiesSpawned = enemiesSpawned + 1
            spawnTimer = 0
            lastAradoY = lastAradoY - 150 + math.random(300)  
            aradoAdditonalSpeed = math.min(aradoAdditonalSpeed + 30, 900)
            
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

            if ocean:collides(arado) and arado.isSunk == false then
                arado:splash()
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
                    arado:hit()
                    
                    bullet.remove = true
                    -- arado.remove = true
                    score = score + 50
                    ui:setScore(score)
                end
            end
            
        end

        if torpedo and torpedo:collides(bismarck) then
            sounds['explosion']:stop()
            sounds['explosion']:play()
            bismarck.isSinking = true
            bismarck.speed = 0.025
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

    love.graphics.draw(sea_top, -topSeaScroll, VIRTUAL_HEIGHT - 49)

    bismarck:render()
    player1:render()
    for k, arado in pairs(arados) do
        arado:render()
    end

    for k, arado in pairs(arados) do
        arado:renderParticles()
    end

    for key, bullet in pairs(bullets) do
        bullet:render()
    end

    ui:render()

    if torpedo then torpedo:render() end

    love.graphics.draw(sea_bottom, -bottomSeaScroll, VIRTUAL_HEIGHT - 40)
end

function PlayState:exit() 
end