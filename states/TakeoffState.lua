TakeoffState = Class{__includes = BaseState}

require 'classes/UI'
require 'classes/Player'
require 'classes/Torpedo'
require 'classes/ArkRoyal'

local isScrolling = true
local sea_top = love.graphics.newImage('graphics/sea_top.png')
local sea_bottom = love.graphics.newImage('graphics/sea_bottom.png')

function TakeoffState:init()
    ui = UI()
    player1 = Player(50, 420)
    arkRoyal = ArkRoyal()
end

function TakeoffState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('title')
    end

    topSeaScroll = (topSeaScroll + 20 * dt) 
        % GROUND_LOOPING_POINT
    
    bottomSeaScroll = (bottomSeaScroll + 30 * dt) 
        % GROUND_LOOPING_POINT

    if isScrolling then
        player1:update(dt)
        ui:setAltitude(500 - math.ceil(player1.y))
    end
end

function TakeoffState:render()
    love.graphics.draw(sea_top, -topSeaScroll, VIRTUAL_HEIGHT - 49)
    player1:render()
    arkRoyal:render()
  
    ui:render()

    love.graphics.draw(sea_bottom, -bottomSeaScroll, VIRTUAL_HEIGHT - 40)
end

function TakeoffState:exit() 
end