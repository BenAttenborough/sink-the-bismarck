push = require 'libs/push'
Class = require 'libs/class'

require 'classes/Player'
require 'classes/Bismarck'
require 'classes/Arado'
require 'classes/Bullet'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1024
VIRTUAL_HEIGHT = 576

local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 1024

local groundScroll = 0
local GROUND_SCROLL_SPEED = 100
local GROUND_LOOPING_POINT = 900

local background = love.graphics.newImage('graphics/background2.png')
local sea = love.graphics.newImage('graphics/sea.png')

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) 
        % GROUND_LOOPING_POINT

    if gameState == 'play' then
        player1:update(dt)
        arado1:update(dt)
        if bullet then
            bullet:update(dt)
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
    arado1 = Arado(VIRTUAL_WIDTH + 50, 100)

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
            print('Game started')
            gameState = 'play'
        end
    end
    if gameState == 'play' then
        if key == 'space' then
            bullet = Bullet(player1.x + player1.width - 30, player1.y + 15)
            print('Shooting')
            print(player1.x)
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
        -- bismarck1:render()
        arado1:render()
        if bullet then
            bullet:render()
        end
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