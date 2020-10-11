TitleState = Class{__includes = BaseState}




function TitleState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function TitleState:render()
    love.graphics.setFont(gTitleFont)
    love.graphics.setColor(204/255, 33/255, 75/255)
    love.graphics.printf('SINK THE BISMARCK!', 0, 40, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gPlayFont)
    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.printf('Press enter to start', 0, VIRTUAL_HEIGHT / 2 - 150, VIRTUAL_WIDTH, 'center')  
end