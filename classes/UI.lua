UI = Class{}

function UI:init()
    self.x = 0
    self.y = 0
    self.width = WINDOW_WIDTH
    self.height = 35
    self.score = 0
    self.altitude = 0
end

function UI:update(dt)
    
end

function UI:setScore(amount)
    self.score = amount
end

function UI:setAltitude(amount)
    self.altitude = amount
end

function UI:render()
    love.graphics.setColor( 0, 0, 0, 1 )
    love.graphics.rectangle( 'fill', self.x, self.y, self.width, self.height )
    love.graphics.setFont(gSmallFont)
    love.graphics.setColor(200, 0, 0, 255)
    love.graphics.print('Altitude: ' .. tostring(self.altitude), 10, 10)
    love.graphics.print('Score: ' .. tostring(self.score), VIRTUAL_WIDTH - 100, 10)
end