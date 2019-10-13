local Block = {
    x = 30,
    y = 95,
    width = 20,
    height = 10
}

function Block:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Block:isColliding(x, y, width, height)
    return self.x + self.width > x and self.x < x + width 
            and self.y + self.height > y and self.y < y + height
            and self.height > 0
end

function Block:shrink(amount)
    if block.height > 0 then
        block.height = block.height + amount
        if amount > 0 then
            block.y = block.y + 1
        end
    end
end

return Block