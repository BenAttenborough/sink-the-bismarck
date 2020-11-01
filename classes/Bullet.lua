Bullet = Class{}

function Bullet:init(x,y)
    self.x = x
    self.y = y
    self.width = 2
    self.height = 2
    self.dx = 0
    self.speed = 10
    self.remove = false
    self.rotationOriginX = 115
    self.rotationOriginY = 52
end

function Bullet:update(dt)
    self.dx = self.dx + (self.speed * dt)
    self.x = self.x + self.speed
    if self.x > VIRTUAL_WIDTH then
        self.remove = true
    end
end

function Bullet:collides(obstacle)
    if (self.x - self.rotationOriginX + 2) + (self.width - 4) >= obstacle.x and self.x - self.rotationOriginX + 2 <= obstacle.x + obstacle.width then
        if (self.y + 2 - self.rotationOriginY) + (self.height - 4) >= obstacle.y and self.y + 2 - self.rotationOriginY <= obstacle.y + obstacle.height then
            return true
        end
    end

    return false
end

function Bullet:render()
    love.graphics.setColor( 150/255, 0, 0, 1 )
    love.graphics.rectangle( 'fill', self.x - self.rotationOriginX, self.y - self.rotationOriginY, 2, 2 )
    love.graphics.setColor(1, 1, 1)
end