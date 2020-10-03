push = require 'libs/push'
Class = require 'libs/class'

require 'classes/Player'

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
-- local playerGraphic = love.graphics.newImage('graphics/swordfish.png')
local bismarckGraphic = love.graphics.newImage('graphics/bismarck.png')

function love.update(dt)
    -- scroll background by preset speed * dt, looping back to 0 after the looping point
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) 
        % GROUND_LOOPING_POINT
end

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Sink the Bismarck!')

    titleFont = love.graphics.newFont('font.ttf', 64)
    playFont = love.graphics.newFont('font.ttf', 32)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    player1 = Player(50, 100)

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

    -- love.graphics.clear(184, 225, 245, 255)
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
        love.graphics.draw(bismarckGraphic, 100, VIRTUAL_HEIGHT - 375)
    end

    -- end rendering at virtual resolution
    push:apply('end')
end