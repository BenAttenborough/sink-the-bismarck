WinState = Class{__includes = BaseState}

local sea_top = love.graphics.newImage('graphics/sea_top.png')
local sea_bottom = love.graphics.newImage('graphics/sea_bottom.png')

function WinState:enter(params)
    self.score = params.score
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
end

function WinState:render()
    love.graphics.setFont(gTitleFont)
    love.graphics.setColor(204/255, 33/255, 75/255)
    love.graphics.printf('YOU SANK THE BISMARCK!', 0, 40, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gPlayFont)
    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.printf('Your score was ' .. tostring(self.score), 0, VIRTUAL_HEIGHT / 2 - 150, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press enter to try again', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
    
    love.graphics.draw(sea_top, -topSeaScroll, VIRTUAL_HEIGHT - 49)
    love.graphics.draw(sea_bottom, -bottomSeaScroll, VIRTUAL_HEIGHT - 40)
end

function WinState:exit() end