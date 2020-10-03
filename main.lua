push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1024
VIRTUAL_HEIGHT = 576

local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 1024

local groundScroll = 0
local GROUND_SCROLL_SPEED = 100
local GROUND_LOOPING_POINT = 1000

local background = love.graphics.newImage('graphics/background2.png')
local sea = love.graphics.newImage('graphics/sea.png')
local playerGraphic = love.graphics.newImage('graphics/swordfish.png')
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

    smallFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')

    -- love.graphics.clear(184, 225, 245, 255)
    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(sea, -groundScroll, VIRTUAL_HEIGHT - 50)
    love.graphics.draw(playerGraphic, 50, 100)
    love.graphics.draw(bismarckGraphic, 100, VIRTUAL_HEIGHT - 375)

    -- condensed onto one line from last example
    -- note we are now using virtual width and height now for text placement
    love.graphics.printf('SINK THE BISMARCK!', 0, 20, VIRTUAL_WIDTH, 'center')

    -- end rendering at virtual resolution
    push:apply('end')
end