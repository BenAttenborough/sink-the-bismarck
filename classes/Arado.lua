Arado = Class{}

local ARADO_GRAPHIC = love.graphics.newImage('graphics/arado.png')

function Arado:init(x,y)
    self.x = x
    self.y = y
    self.dx = 0
    self.speed = 1
end

function Arado:update(dt)
    self.dx = self.dx - self.speed * dt
    self.x = self.x + self.dx
end

function Arado:render()
    love.graphics.draw(ARADO_GRAPHIC, self.x, self.y)
end