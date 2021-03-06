local TORPEDO_GRAPHIC = love.graphics.newImage('graphics/torpedo.png')
local SPRAY_GRAPHIC = love.graphics.newImage('graphics/spray.png')

Torpedo = Class{}

function Torpedo:init(x,y)
    self.x = x
    self.y = y
    self.dy = 0
    self.dx = 0
    self.offsetX = 70
    self.offsetY = 39
    self.speedY = 200
    self.speedX = 150
    self.height = TORPEDO_GRAPHIC:getHeight()
    self.width = TORPEDO_GRAPHIC:getWidth()
    self.isDropped = false
    self.isInAir = true
end

function Torpedo:update(dt, x, y)
    -- Reset velocity each frame (otherwise sprite will continually move)
    self.dy = 0
    self.dx = 0

    if self.isDropped then
        if self.y > VIRTUAL_HEIGHT - self.height - 55 then self.isInAir = false end
        if self.isInAir then
            self.dy = self.speedY
            self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
        else
            self.dx = self.speedX
            self.x = math.min(VIRTUAL_WIDTH - self.width + 50, self.x + self.dx * dt)
        end
    else
        self.x = x + self.offsetX
        self.y = y + self.offsetY
    end

    if self.isDropped == false then

        if love.keyboard.wasPressed('z') then
            self.isDropped = true
        end
    end
end

function Torpedo:collides(obstacle)
    if self.isInAir then return false end
    if (self.x + 2) + (self.width - 4) >= obstacle.x and self.x + 2 <= obstacle.x + obstacle.width then
        if (self.y + 2) + (self.height - 4) >= obstacle.y and self.y + 2 <= obstacle.y + obstacle.height then
            return true
        end
    end
    return false
end

function Torpedo:render()
    if self.isInAir then
        love.graphics.draw(TORPEDO_GRAPHIC, self.x, self.y)
    else
        love.graphics.draw(SPRAY_GRAPHIC, self.x, self.y)
    end
end

function Torpedo:renderLaunch(rotation)
    love.graphics.draw(TORPEDO_GRAPHIC, self.x - self.offsetX, self.y - self.offsetY - 12, math.rad(rotation), 1, 1, 50)
end