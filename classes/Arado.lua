Arado = Class{}

local ARADO_GRAPHIC = love.graphics.newImage('graphics/arado.png')
local BANG_GRAPHIC = love.graphics.newImage('graphics/bang.png')
local EXPLOSION_GRAPHIC = love.graphics.newImage('graphics/particle.png')

function Arado:init(y)
    self.x = VIRTUAL_WIDTH + 50
    self.y = y
    self.dx = 0
    self.speed = 3
    self.width = ARADO_GRAPHIC:getWidth()
    self.height = ARADO_GRAPHIC:getHeight()
    self.remove = false
    self.psystemExplosion = love.graphics.newParticleSystem(EXPLOSION_GRAPHIC, 64)
    self.psystemSmoke = love.graphics.newParticleSystem(EXPLOSION_GRAPHIC, 64)
    -- lasts between 0.5-1 seconds seconds
    self.psystemExplosion:setParticleLifetime(0.5, 1)
    self.psystemSmoke:setParticleLifetime(2, 3)

    -- give it an acceleration of anywhere between X1,Y1 and X2,Y2 (0, 0) and (80, 80) here
    -- gives generally downward 
    self.psystemExplosion:setLinearAcceleration(-15, 0, 15, 80)
    self.psystemSmoke:setLinearAcceleration(15, 0, 0, -80)

    -- spread of particles; normal looks more natural than uniform, which is clumpy; numbers
    -- are amount of standard deviation away in X and Y axis
    self.psystemExplosion:setEmissionArea('uniform', 15, 15)
    self.psystemSmoke:setEmissionArea('uniform', 10, 10)
end

function Arado:update(dt)
    if self.x < -self.width then
        self.remove = true
    else
        self.dx = self.dx - (self.speed * dt)
        self.x = self.x + self.dx
    end
    self.psystemExplosion:update(dt)
    self.psystemSmoke:update(dt)
end

function Arado:hit()
    sounds['explosion']:stop()
    sounds['explosion']:play()
    self.psystemExplosion:setColors(
        251 / 255,
        242 / 255,
        54 / 255,
        150 / 255,
        200 / 255,
        200 / 255,
        200 / 255,
        0
    )
    self.psystemExplosion:emit(64)
    self.psystemSmoke:setColors(
        255 / 255,
        255 / 255,
        255 / 255,
        150 / 255,
        255 / 255,
        255 / 255,
        255 / 255,
        0
    )
    self.psystemSmoke:emit(64)
end

function Arado:render()
    love.graphics.draw(ARADO_GRAPHIC, self.x, self.y)
end

function Arado:renderParticles()
    love.graphics.draw(self.psystemExplosion, self.x + 40, self.y + 20)
    love.graphics.draw(self.psystemSmoke, self.x + 40, self.y + 20)
end