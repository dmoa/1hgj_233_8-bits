local Bullets = {
    bullets = {},
    bulletW = 1,
    bulletH = 5,
    bulletYV = 5
}

function Bullets:draw()
    for _, bullet in ipairs(self.bullets) do
        love.graphics.rectangle("fill", math.floor(bullet.x), math.floor(bullet.y), self.bulletW, self.bulletH)
    end
end

function Bullets:update(dt)

    for k, bullet in ipairs(self.bullets) do

        print(k)

        bullet.y = bullet.y + self.bulletYV * bullet.direction
        if bullet.y < 0 then
            bullet.DELETE = true
        end
    end

    for k, bullet in ipairs(self.bullets) do
        if bullet.DELETE then
            self.bullets[k] = nil
        end
    end

end

function Bullets:newBullet(_x, _y, _direction)
    table.insert(self.bullets, {x = _x, y = _y, direction = _direction})
end

return Bullets