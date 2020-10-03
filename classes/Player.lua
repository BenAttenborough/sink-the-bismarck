Player = Class{}

function Player:init(x,y)
    local graphic = love.graphics.newImage('graphics/swordfish.png')
    self.x = x
    self.y = y
    self.dy = 0
    self.dx = 0
    self.graphic = graphic
    self.height = graphic:getHeight()
end

function Player:update(dt)
    -- math.max here ensures that we're the greater of 0 or the player's
    -- current calculated Y position when pressing up so that we don't
    -- go into the negatives; the movement calculation is simply our
    -- previously-defined paddle speed scaled by dt
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    -- similar to before, this time we use math.min to ensure we don't
    -- go any farther than the bottom of the screen minus the paddle's
    -- height (or else it will go partially below, since position is
    -- based on its top left corner)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
end

function Player:render()
    love.graphics.draw(self.graphic, self.x, self.y)
end