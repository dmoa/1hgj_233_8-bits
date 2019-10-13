local Player = {
    x = 0,
    y = 0,
    xv = 0,
    xv_acceleration = 1200,
    xvMax = 140,
    friction = 0.00001,
    yv = 0,
    image = love.graphics.newImage("player.png"),
    jumping = false,
}

function Player:draw()
    love.graphics.draw(self.image, math.floor(self.x), math.floor(self.y))
end

function Player:update(dt)
    self:movement(dt)
    self:collision()
end

function Player:movement(dt)
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then self.xv = self.xv - self.xv_acceleration * dt end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then self.xv = self.xv + self.xv_acceleration * dt end

    if not love.keyboard.isDown("a") and not love.keyboard.isDown("d") and not love.keyboard.isDown("right") and not love.keyboard.isDown("left") then
        self.xv = self.xv * math.pow(self.friction, dt)
    end 

    if self.xv > self.xvMax then self.xv = self.xvMax end
    if self.xv < -self.xvMax then self.xv = -self.xvMax end
    
    self.oldX = self.x
    self.oldY = self.y
    self.x = self.x + self.xv * dt
    self.y = self.y + self.yv * dt
    self.yv = self.yv + 400 * dt
    
    if love.keyboard.isDown("space") then
        self:jump_shoot()
    end
end

function Player:collision()
    if self.y + self.image:getHeight() > gameWL then
        self.y = gameWL - self.image:getHeight()
        self.yv = 0
        self.jumping = false
    end
    if self.x < 0 then
        self.x = 0
        self.xv = 0
    end
    if self.x + self.image:getWidth() > gameWL then
        self.x = gameWL - self.image:getWidth()
        self.xv = 0
    end
    
    if block:isColliding(self.x, self.y, self.image:getWidth(), self.image:getHeight()) then
        if self.oldX + self.image:getWidth() <= block.x then
            self.x = block.x - self.image:getWidth()
            self.oldX = self.x
            self.xv = 0
        end
    end
    if block:isColliding(self.x, self.y, self.image:getWidth(), self.image:getHeight()) then
        if self.oldX >= block.x + block.width then
            self.x = block.x + block.width
            self.oldX = self.x
            self.xv = 0
        end
    end
    if block:isColliding(self.x, self.y, self.image:getWidth(), self.image:getHeight()) then
        if self.oldY + self.image:getHeight() <= block.y then
            self.y = block.y - self.image:getHeight()
            self.oldY = self.y
            self.yv = 0
            self.jumping = false
        end
    end
    if block:isColliding(self.x, self.y, self.image:getHeight(), self.image:getHeight()) then
        if self.oldY >= block.y + block.height then
            self.y = block.y + block.height
            self.oldY = self.y
            self.yv = 0
        end
    end

    if not (self.yv == 0) then 
        self.jumping = true
    end
    
end

function Player:jump_shoot()
    if not self.jumping then 
        self.yv = -150
        self.y = self.y
        self.jumping = true
        bullets:newBullet(self.x + self.image:getHeight() / 2, self.y - bullets.bulletH, -1)
    end
end

return Player