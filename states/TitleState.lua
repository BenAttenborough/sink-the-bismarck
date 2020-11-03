TitleState = Class{__includes = BaseState}

require 'classes/Bismarck'

local sea_top = love.graphics.newImage('graphics/sea_top.png')
local sea_bottom = love.graphics.newImage('graphics/sea_bottom.png')

function TitleState:init()
    bismarck = Bismarck(1050, VIRTUAL_HEIGHT - 375)
end

function TitleState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    topSeaScroll = (topSeaScroll + TOP_SEA_SCROLL_SPEED * dt) 
        % GROUND_LOOPING_POINT
    
    bottomSeaScroll = (bottomSeaScroll + BOTTOM_SEA_SCROLL_SPEED * dt) 
        % GROUND_LOOPING_POINT

    bismarck:updateIntro(dt)
    
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('takeoff')
    end
end

function TitleState:render()
    love.graphics.setFont(gTitleFont)
    love.graphics.setColor(204/255, 33/255, 75/255)
    love.graphics.printf('SINK THE BISMARCK!', 0, 40, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gPlayFont)
    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.printf('Controls: cursor keys to move', 0, VIRTUAL_HEIGHT / 2 - 150, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Space to fire, z to drop torpedo', 0, VIRTUAL_HEIGHT / 2 - 110, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press enter to start', 0, VIRTUAL_HEIGHT / 2 - 60, VIRTUAL_WIDTH, 'center')
    
    love.graphics.draw(sea_top, -topSeaScroll, VIRTUAL_HEIGHT - 49)
    bismarck:render()
    love.graphics.draw(sea_bottom, -bottomSeaScroll, VIRTUAL_HEIGHT - 40)

end

function TitleState:exit() end