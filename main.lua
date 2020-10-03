push = require 'libs/push'
Class = require 'libs/class'

require 'classes/Player'
require 'classes/Bismarck'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1024
VIRTUAL_HEIGHT = 576

PLAYER_SPEED_Y = 200
PLAYER_SPEED_X = 150

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
    
    if love.keyboard.isDown('up') then
        player1.dy = -PLAYER_SPEED_Y
    elseif love.keyboard.isDown('down') then
        player1.dy = PLAYER_SPEED_Y
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('left') then
        player1.dx = -PLAYER_SPEED_X
    elseif love.keyboard.isDown('right') then
        player1.dx = PLAYER_SPEED_X
    else
        player1.dx = 0
    end

    player1:update(dt)
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
    bismarck1 = Bismarck(100, VIRTUAL_HEIGHT - 375)

    gameState = 'start'
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if gameState == 'start' then
        if key == 'enter' or key == 'return' then
            gameState = 'play'
        end
    end
end

function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')

    love.graphics.clear(184, 225, 245, 255)
    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(sea, -groundScroll, VIRTUAL_HEIGHT - 49)


    if gameState == 'start' then
        love.graphics.setFont(titleFont)
        love.graphics.setColor(204, 33, 75)
        love.graphics.printf('SINK THE BISMARCK!', 0, 40, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(playFont)
        love.graphics.setColor(255, 255, 255)
        love.graphics.printf('Press enter to start', 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        player1:render()
        bismarck1:render()
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