ArkRoyal = Class{}

function ArkRoyal:init()
    self.x = 10
    self.y = VIRTUAL_HEIGHT - 100
    self.graphic = love.graphics.newImage('graphics/bismarckv2.png')
    self.speed = 0.1
    self.width = 500
    self.height = 200
end

function ArkRoyal:update(dt)
    -- self.dx = self.dx - self.speed * dt
    -- self.x = self.x + self.dx
end

function ArkRoyal:render()
    love.graphics.setColor( 150/255, 0, 0, 1 )
    love.graphics.rectangle( 'fill', self.x, self.y, self.width, self.height )
    love.graphics.setColor(1, 1, 1)
end