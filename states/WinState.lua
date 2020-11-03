WinState = Class{__includes = BaseState}

require 'classes/ScoreTitle'

local sea_top = love.graphics.newImage('graphics/sea_top.png')
local sea_bottom = love.graphics.newImage('graphics/sea_bottom.png')

function WinState:enter(params)
    self.score = params.score
    self.scoreTitle = ScoreTitle(params.enemiesDowned)
end

function WinState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('title')
    end

    topSeaScroll = (topSeaScroll + TOP_SEA_SCROLL_SPEED * dt) 
        % GROUND_LOOPING_POINT
    
    bottomSeaScroll = (bottomSeaScroll + BOTTOM_SEA_SCROLL_SPEED * dt) 
        % GROUND_LOOPING_POINT
    
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('title')
    end

    self.scoreTitle:update(dt)
end

function WinState:render()
    self.scoreTitle:render()
end

function WinState:exit() end