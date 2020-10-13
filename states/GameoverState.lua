GameoverState = Class{__includes = BaseState}

function GameoverState:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('title')
    end
end

function GameoverState:render()
    love.graphics.setFont(gTitleFont)
    love.graphics.setColor(204/255, 33/255, 75/255)
    love.graphics.printf('GAME OVER!', 0, 40, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gPlayFont)
    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.printf('Press enter to restart', 0, VIRTUAL_HEIGHT / 2 - 150, VIRTUAL_WIDTH, 'center')  
end