require 'utils/generalUtils'

local PLAYER_GRAPHIC = love.graphics.newImage('graphics/swordfishv2.png')
local planeAtlas = love.graphics.newImage('graphics/swordfishv3.png')
local planeFrames = generateQuads(planeAtlas, 150, 58)

TakeoffPlane = Class{}

function TakeoffPlane:init(x,y)
    self.x = x
    self.y = y
    self.dy = 0
    self.dx = 0
    self.speedY = 200
    self.speedX = 50
    self.height = PLAYER_GRAPHIC:getHeight()
    self.width = PLAYER_GRAPHIC:getWidth()
    self.firedRecently = false
    self.bulletTimer = 0
    self.planeFrame = 1
    self.playerTimer = Timer.new()
    self.state = 'takeoff'
    self.rotation = -10
    self.rotationOriginX = 115
    self.rotationOriginY = 52
    self.grounded = true
end

function TakeoffPlane:spinProp()
    self.playerTimer:every(0.1, function() 
        if self.planeFrame == 4 then 
            self.planeFrame = 1 
        else 
            self.planeFrame = self.planeFrame + 1 
        end
    end)
end

function TakeoffPlane:update(dt)
    self.playerTimer:update(dt)
    
    -- Reset velocity each frame (otherwise sprite will continually move)
    self.dy = 0

    if love.keyboard.wasHeld('left') then
        -- self.dx = -self.speedX
    elseif love.keyboard.wasHeld('right') then
        self.dx = math.min(self.dx + (self.speedX * dt), 200)
    end

    if love.keyboard.wasHeld('up') then
        -- self.rotation = self.rotation + 1
    elseif love.keyboard.wasHeld('down') then
        -- self.rotation = self.rotation - 1 
    end

    if self.dy < 35 then
        self.y = math.max(35, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height - 50, self.y + self.dy * dt)
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end

    if self.dx > 150 and self.grounded then
        self.grounded = false
        self:moveToHorizontal()
    end
end

function TakeoffPlane:collides(obstacle)
    if (self.x + 2) + (self.width - 4) >= obstacle.x and self.x + 2 <= obstacle.x + obstacle.width then
        if (self.y + 2) + (self.height - 4) >= obstacle.y and self.y + 2 <= obstacle.y + obstacle.height then
            return true
        end
    end

    return false
end

function TakeoffPlane:spinProp()
    self.playerTimer:every(0.1, function() 
        if self.planeFrame == 4 then 
            self.planeFrame = 1 
        else 
            self.planeFrame = self.planeFrame + 1 
        end
    end)
end

function TakeoffPlane:moveToHorizontal()
    self.playerTimer:tween(2, self, {rotation = 0})
end

function TakeoffPlane:render()
    love.graphics.draw(planeAtlas, planeFrames[self.planeFrame], self.x, self.y, math.rad(self.rotation), 1, 1, self.rotationOriginX, self.rotationOriginY)
    -- love.graphics.setColor( 150/255, 0, 0, 1 )
    -- love.graphics.rectangle( 'fill',  self.x, self.y, 2, 2 )
    -- love.graphics.setColor(1, 1, 1)
end