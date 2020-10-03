Bismarck = Class{}

function Bismarck:init(x,y)
    self.x = x
    self.y = y
    self.graphic = love.graphics.newImage('graphics/bismarck.png')
end

function Bismarck:render()
    love.graphics.draw(self.graphic, self.x, self.y)
end