function love.load()
    WL = love.graphics.getDimensions()
    love.graphics.setDefaultFilter("nearest", "nearest", 1, 1)
    gameWL = 128
    mainCanvas = love.graphics.newCanvas(gameWl, gameWl)
    scale = WL / gameWL

    startup()
end

function love.draw()

    love.graphics.setCanvas(mainCanvas)
    love.graphics.clear()
    
    player:draw()
    block:draw()
    bullets:draw()

    love.graphics.setCanvas()
    love.graphics.draw(mainCanvas, 0, 0, 0, scale, scale)
end

function love.update(dt)
    player:update(dt)
    bullets:update(dt)
end

function love.keypressed(key)
    if key == "escape" then love.event.quit() end
end

function startup()
    player = require("Player")
    block = require("Block")
    bullets = require("Bullets")

    loop = love.audio.newSource("loop.wav", "stream")
    loop:setLooping(true)
    loop:play()
end