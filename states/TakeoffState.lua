TakeoffState = Class{__includes = BaseState}

require 'classes/UI'
require 'classes/TakeoffPlane'
require 'classes/Torpedo'
require 'classes/ArkRoyal'

local isScrolling = true
local sea_top = love.graphics.newImage('graphics/sea_top.png')
local sea_bottom = love.graphics.newImage('graphics/sea_bottom.png')

function TakeoffState:init()
    ui = UI()
    player1 = TakeoffPlane(300, 435)
    arkRoyal = ArkRoyal()
    player1:spinProp()
end

function TakeoffState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('title')
    end

    topSeaScroll = (topSeaScroll + 20 * dt) 
        % GROUND_LOOPING_POINT
    
    bottomSeaScroll = (bottomSeaScroll + 30 * dt) 
        % GROUND_LOOPING_POINT

    ui:setSpeed(player1.dx)

    if isScrolling then
        player1:update(dt)
        arkRoyal:update(dt)
        ui:setAltitude(500 - math.ceil(player1.y))
    end

    if player1.x > player1.width + 400 then
        arkRoyal.move = true
        arkRoyal.dx = player1.dx
    end
end

function TakeoffState:render()
    love.graphics.draw(sea_top, -topSeaScroll, VIRTUAL_HEIGHT - 49)
    arkRoyal:render()
    player1:render()
    ui:render()

    love.graphics.draw(sea_bottom, -bottomSeaScroll, VIRTUAL_HEIGHT - 40)
end

function TakeoffState:exit() 
end