Player = Class{}

function Player:init(x,y)
    self.x = x
    self.y = y
    self.dy = 0
    self.dx = 0
    self.speedY = 200
    self.speedX = 150
    self.graphic = love.graphics.newImage('graphics/swordfish.png')
    self.height = self.graphic:getHeight()
    self.width = self.graphic:getWidth()
end

function Player:update(dt)
    -- Reset velocity each frame (otherwise sprite will continually move)
    self.dy = 0
    self.dx = 0

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
    
    -- If velocity move sprite, clamping it to the screen dimensions
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Player:render()
    love.graphics.draw(self.graphic, self.x, self.y)
end