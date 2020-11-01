ArkRoyal = Class{}

function ArkRoyal:init()
    self.x = -400
    self.y = 100
    self.graphic = love.graphics.newImage('graphics/arkroyal-old.png')
    -- self.speed = 0.1
    self.dx = 0
    self.width = 500
    self.height = 200
    self.move = false
end

function ArkRoyal:update(dt)
    -- self.dx = self.dx - self.speed * dt
    -- self.x = self.x + self.dx
    if self.move == true then
        self.x = self.x - (self.dx * dt)
    end
end

function ArkRoyal:render()
    love.graphics.draw(self.graphic, self.x, self.y)
end