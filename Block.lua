local Block = {
    x = 30,
    y = 105,
    width = 20,
    height = 10
}

function Block:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Block:isColliding(x, y, width, height)
    return self.x + self.width > x and self.x < x + width 
            and self.y + self.height > y and self.y < y + height
end

return Block