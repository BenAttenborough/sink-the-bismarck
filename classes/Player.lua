Player = Class{}

function Player:init(x,y)
    self.x = x
    self.y = y
    self.graphic = love.graphics.newImage('graphics/swordfish.png')
end

function Player:render()
    love.graphics.draw(self.graphic, self.x, self.y)
end