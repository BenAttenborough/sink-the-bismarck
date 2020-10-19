Bismarck = Class{}

function Bismarck:init(x,y)
    self.x = x
    self.y = y
    self.graphic = love.graphics.newImage('graphics/bismarck.png')
    self.dx = 0
    self.speed = 0.1
end

function Bismarck:update(dt)
    self.dx = self.dx - self.speed * dt
    self.x = self.x + self.dx
end

function Bismarck:updateIntro(dt)
    if self.x > -400 then
        self.dx = self.dx - self.speed * dt
        self.x = self.x + self.dx
    end
end

function Bismarck:move(dt)
    if self.x > -800 then
        self.dx = self.dx - self.speed * dt
        self.x = self.x + self.dx
    end
end

function Bismarck:render()
    love.graphics.draw(self.graphic, self.x, self.y)
end