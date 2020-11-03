ScoreTitle = Class{}

function ScoreTitle:init(enemiesDowned)
    self.x = 0
    self.y = 576
    self.names = getNames(enemiesDowned)
end

function ScoreTitle:update(dt)
    self.y = self.y - (20 * dt)
end

function ScoreTitle:render()
    love.graphics.setFont(gTitleFont)
    love.graphics.setColor(204/255, 33/255, 75/255)
    love.graphics.printf('YOU SANK THE BISMARCK!', self.x, self.y, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255/255, 255/255, 255/255)
    love.graphics.setFont(gPlayFont)
    y = self.y + 100
    love.graphics.printf('You killed the following pilots', self.x, y, VIRTUAL_WIDTH, 'center')
    y = y + 60
    for i=1,10 do
        love.graphics.printf(self.names[i], self.x, y, VIRTUAL_WIDTH, 'center')
        y = y + 30
    end
end

function getFirstNames()
    firstNames = {}
    table.insert(firstNames, "Hans")
    table.insert(firstNames, "Peter")
    table.insert(firstNames, "Klaus")
    table.insert(firstNames, "Wolfgang")
    table.insert(firstNames, "Jurgen")
    table.insert(firstNames, "Dieter")
    table.insert(firstNames, "Manfred")
    table.insert(firstNames, "Uwe")
    table.insert(firstNames, "Gunter")
    return firstNames
end

function getSecondNames()
    secondNames = {}
    table.insert(secondNames, "Muller")
    table.insert(secondNames, "Schmidt")
    table.insert(secondNames, "Schneider")
    table.insert(secondNames, "Fischer")
    table.insert(secondNames, "Weber")
    table.insert(secondNames, "Meyer")
    table.insert(secondNames, "Wagner")
    table.insert(secondNames, "Becker")
    table.insert(secondNames, "Hoffmann")
    table.insert(secondNames, "Bauer")
    table.insert(secondNames, "Richter")
    table.insert(secondNames, "Klein")
    table.insert(secondNames, "Wolf")
    table.insert(secondNames, "Schroder")
    table.insert(secondNames, "Neumann")
    table.insert(secondNames, "Schwarz")
    table.insert(secondNames, "Zimmermann")
    table.insert(secondNames, "Braun")
    table.insert(secondNames, "Kruger")
    table.insert(secondNames, "Hofmann")
    table.insert(secondNames, "Werner")
    return secondNames
end

function getNames(enemiesDowned)
    names = {}
    firstNames = getFirstNames()
    secondNames = getSecondNames()
    if enemiesDowned then
        for i = 1, enemiesDowned do
            first = firstNames[math.random(#firstNames)]
            second = secondNames[math.random(#secondNames)]
            name = first .. " " .. second .. ", " .. math.random(18, 38)
            print(name)
            table.insert(names, name)
        end
    end
    return names
end