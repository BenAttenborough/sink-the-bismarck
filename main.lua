push = require 'libs/push'
Class = require 'libs/class'

require 'StateMachine'
require 'states/BaseState'
require 'states/TitleState'
require 'states/PlayState'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1024
VIRTUAL_HEIGHT = 576
VIRTUAL_PLAYAREA_HEIGHT = VIRTUAL_HEIGHT - 100

PLAYER_FIRING_INTERVAL = 0.25

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

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Sink the Bismarck!')

    gTitleFont = love.graphics.newFont('font.ttf', 64)
    gPlayFont = love.graphics.newFont('font.ttf', 32)
    gSmallFont = love.graphics.newFont('font.ttf', 16)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleState() end,
        ['play'] = function() return PlayState() end,
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
    love.keyboard.keysHeld = {}
end

function love.resize(w, h)
    push:resize(w, h)
end 

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    love.keyboard.keysHeld[key] = true
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

    gStateMachine:render()
    

    push:apply('end')
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(gSmallFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end