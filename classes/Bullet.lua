Bullet = Class{}

function Bullet:init(x,y)
    self.x = x
    self.y = y
    self.width = 2
    self.height = 2
    self.dx = 0
    self.speed = 10
    self.remove = false
end

function Bullet:update(dt)
    self.dx = self.dx + (self.speed * dt)
    self.x = self.x + self.speed
    if self.x > VIRTUAL_WIDTH then
        self.remove = true
    end
end

function Bullet:collides(obstacle)
    if (self.x + 2) + (self.width - 4) >= obstacle.x and self.x + 2 <= obstacle.x + obstacle.width then
        if (self.y + 2) + (self.height - 4) >= obstacle.y and self.y + 2 <= obstacle.y + obstacle.height then
            return true
        end
    end

    return false
end

function Bullet:render()
    love.graphics.setColor( 150/255, 0, 0, 1 )
    love.graphics.rectangle( 'fill', self.x, self.y, 2, 2 )
    love.graphics.setColor(1, 1, 1)
end