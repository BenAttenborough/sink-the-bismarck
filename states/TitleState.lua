TitleState = Class{__includes = BaseState}

require 'classes/Bismarck'

function TitleState:init()
    bismarck = Bismarck(1050, VIRTUAL_HEIGHT - 375)
end

function TitleState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    bismarck:updateIntro(dt)
    
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
    bismarck:render()
end

function TitleState:exit() end