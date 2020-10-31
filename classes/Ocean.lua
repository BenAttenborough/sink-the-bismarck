Ocean = Class{}

function Ocean:init() 
    self.width = VIRTUAL_WIDTH 
    self.height = 200
    self.x = 0
    self.y = VIRTUAL_HEIGHT - 49
end

function Ocean:collides(obstacle)
    if self.x + self.width >= obstacle.x and self.x <= obstacle.x + obstacle.width then
        if (self.y) + (self.height) >= obstacle.y and self.y + 2 <= obstacle.y + obstacle.height then
            return true
        end
    end

    return false
end