push = require 'libs/push'
Class = require 'libs/class'

require 'classes/Player'
require 'classes/Bismarck'
require 'classes/Arado'
-- require 'classes/Bullet'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1024
VIRTUAL_HEIGHT = 576
VIRTUAL_PLAYAREA_HEIGHT = VIRTUAL_HEIGHT - 100

local spawnTimer = 0;

local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 1024

local groundScroll = 0
local GROUND_SCROLL_SPEED = 100
local GROUND_LOOPING_POINT = 900

local background = love.graphics.newImage('graphics/background2.png')
local sea = love.graphics.newImage('graphics/sea.png')

bullets = {}

local arados = {}
local lastAradoY = 0

local isScrolling = true

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) 
        % GROUND_LOOPING_POINT

    if gameState == 'play' then
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
                        -- isScrolling = false
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
    
    if gameState == 'start' then
        bismarck1:updateIntro(dt)
    end

    love.keyboard.keysPressed = {}
end

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Sink the Bismarck!')

    titleFont = love.graphics.newFont('font.ttf', 64)
    playFont = love.graphics.newFont('font.ttf', 32)
    smallFont = love.graphics.newFont('font.ttf', 16)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    player1 = Player(50, 100)
    bismarck1 = Bismarck(1050, VIRTUAL_HEIGHT - 375)
    
    gameState = 'start'

    love.keyboard.keysPressed = {}
    love.keyboard.keysHeld = {}
end

function love.resize(w, h)
    push:resize(w, h)
end 

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    love.keyboard.keysHeld[key] = true
    if key == 'escape' then
        love.event.quit()
    end
    if gameState == 'start' then
        if key == 'enter' or key == 'return' or key == 'space' then
            lastAradoY = math.random(25, WINDOW_HEIGHT - 300)
            gameState = 'play'
        end
    end
end

function love.keyreleased(key)
    love.keyboard.keysHeld[key] = false
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.keyboard.wasHeld(key)
    return love.keyboard.keysHeld[key]
end

function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')

    love.graphics.clear(184/255, 225/255, 245/255, 255/255)
    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(sea, -groundScroll, VIRTUAL_HEIGHT - 49)


    if gameState == 'start' then
        love.graphics.setFont(titleFont)
        love.graphics.setColor(204/255, 33/255, 75/255)
        love.graphics.printf('SINK THE BISMARCK!', 0, 40, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(playFont)
        love.graphics.setColor(255/255, 255/255, 255/255)
        love.graphics.printf('Press enter to start', 0, VIRTUAL_HEIGHT / 2 - 150, VIRTUAL_WIDTH, 'center')
        bismarck1:render()
    elseif gameState == 'play' then
        player1:render()
        for k, arado in pairs(arados) do
            arado:render()
        end

        -- if bullet then
        --     bullet:render()
        -- end
    end

    for key, bullet in pairs(bullets) do
        bullet:render()
    end

    displayFPS()

    -- end rendering at virtual resolution
    push:apply('end')
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end