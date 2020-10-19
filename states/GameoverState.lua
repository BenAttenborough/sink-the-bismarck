GameoverState = Class{__includes = BaseState}

local sea_top = love.graphics.newImage('graphics/sea_top.png')
local sea_bottom = love.graphics.newImage('graphics/sea_bottom.png')

function GameoverState:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('title')
    end

    topSeaScroll = (topSeaScroll + TOP_SEA_SCROLL_SPEED * dt) 
        % GROUND_LOOPING_POINT
    
    bottomSeaScroll = (bottomSeaScroll + BOTTOM_SEA_SCROLL_SPEED * dt) 
        % GROUND_LOOPING_POINT

end

function GameoverState:render()
    love.graphics.setFont(gTitleFont)
    love.graphics.setColor(204/255, 33/255, 75/255)
    love.graphics.printf('GAME OVER!', 0, 40, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gPlayFont)
    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.printf('Press enter to restart', 0, VIRTUAL_HEIGHT / 2 - 150, VIRTUAL_WIDTH, 'center')  

    love.graphics.draw(sea_top, -topSeaScroll, VIRTUAL_HEIGHT - 40)
    love.graphics.draw(sea_bottom, -bottomSeaScroll, VIRTUAL_HEIGHT - 49)

end