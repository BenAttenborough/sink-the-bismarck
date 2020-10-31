require 'classes/Bullet'
require 'utils/generalUtils'

local PLAYER_GRAPHIC = love.graphics.newImage('graphics/swordfishv2.png')
local planeAtlas = love.graphics.newImage('graphics/swordfishv3.png')
local planeFrames = generateQuads(planeAtlas, 150, 58)

Player = Class{}

function Player:init(x,y)
    self.x = x
    self.y = y
    self.dy = 0
    self.dx = 0
    self.speedY = 200
    self.speedX = 150
    self.height = PLAYER_GRAPHIC:getHeight()
    self.width = PLAYER_GRAPHIC:getWidth()
    self.firedRecently = false
    self.bulletTimer = 0
    self.planeFrame = 1
    self.playerTimer = Timer.new()
    self.state = 'takeoff'
end

function Player:spinProp()
    self.playerTimer:every(0.1, function() 
        if self.planeFrame == 4 then 
            self.planeFrame = 1 
        else 
            self.planeFrame = self.planeFrame + 1 
        end
    end)
end

function Player:update(dt)
    self.playerTimer:update(dt)
    
    -- Reset velocity each frame (otherwise sprite will continually move)
    self.dy = 0
    self.dx = 0

    if self.state == 'takeoff' then
        self:takeoff(dt)
    else
        self:flight(dt)
    end
end

function Player:collides(obstacle)
    if (self.x + 2) + (self.width - 4) >= obstacle.x and self.x + 2 <= obstacle.x + obstacle.width then
        if (self.y + 2) + (self.height - 4) >= obstacle.y and self.y + 2 <= obstacle.y + obstacle.height then
            return true
        end
    end

    return false
end

function Player:render()
    love.graphics.draw(planeAtlas, planeFrames[self.planeFrame], self.x, self.y)
end

function Player:takeoff(dt)
    if love.keyboard.wasHeld('left') then
        self.dx = -self.speedX
    elseif love.keyboard.wasHeld('right') then
        self.dx = self.speedX
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
end

function Player:flight(dt)
    -- Check keyboard inputs
    if love.keyboard.wasHeld('up') then
        self.dy = -self.speedY
    elseif love.keyboard.wasHeld('down') then
        self.dy = self.speedY
    end

    if love.keyboard.wasHeld('left') then
        self.dx = -self.speedX
    elseif love.keyboard.wasHeld('right') then
        self.dx = self.speedX
    end

    if love.keyboard.wasHeld('space') then
        if self.firedRecently == false or self.bulletTimer > PLAYER_FIRING_INTERVAL then
            table.insert(bullets, Bullet(self.x + self.width - 30, self.y + 15))
            sounds['shot']:stop()
            sounds['shot']:play()
            self.firedRecently = true
            self.bulletTimer = 0
        end
    else
        self.firedRecently = false
    end

    if self.firedRecently then self.bulletTimer = self.bulletTimer + dt end
    
    -- If velocity move sprite, clamping it to the screen dimensions
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
end