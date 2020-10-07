Bullet = Class{}

function Bullet:init(x,y)
    self.x = x
    self.y = y
    self.dx = 0
    self.speed = 1
end

function Bullet:update(dt)
    self.dx = self.dx + self.speed * dt
    self.x = self.x + self.dx
end

function Bullet:render()
    love.graphics.setColor( 150/255, 0, 0, 1 )
    love.graphics.rectangle( 'fill', self.x, self.y, 2, 2 )
end