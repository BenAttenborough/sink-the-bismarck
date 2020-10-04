Arado = Class{}

function Arado:init(x,y)
    self.x = x
    self.y = y
    self.graphic = love.graphics.newImage('graphics/arado.png')
end

function Arado:render()
    love.graphics.draw(self.graphic, self.x, self.y)
end