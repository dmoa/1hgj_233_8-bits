local Bullets = {
    bullets = {},
    bulletW = 1,
    bulletH = 5,
    bulletYV = 2
}

function Bullets:draw()
    for _, bullet in ipairs(self.bullets) do
        love.graphics.rectangle("fill", math.floor(bullet.x), math.floor(bullet.y), self.bulletW, self.bulletH)
    end
end

function Bullets:update(dt)

    for k, bullet in ipairs(self.bullets) do

        bullet.y = bullet.y + self.bulletYV * bullet.direction
        if bullet.y + self.bulletH < 0 then
            bullet.DELETE = true
        end
        if block:isColliding(bullet.x, bullet.y, self.bulletW, self.bulletH) then
            bullet.DELETE = true
            block:shrink(-1)
        end
    end

    for i = #self.bullets, 1, -1 do
        if self.bullets[i].DELETE then
            table.remove(self.bullets, i)
        end
    end


end

function Bullets:newBullet(_x, _y, _direction)
    table.insert(self.bullets, {x = _x, y = _y, direction = _direction})
end

return Bullets