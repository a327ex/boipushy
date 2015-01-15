Input = require 'Input'

function love.load()
    input = Input()

    input:bind('f1', 'action_1')
    input:bind('f2', function() print(4) end)
    input:bind('fdown', function() print(5) end)
end

function love.update(dt)
    if input:pressed('action_1') then print(1) end
    if input:released('action_1') then print(2) end

    input:update(dt)
end

function love.draw()
    
end

function love.keypressed(key)
    input:keypressed(key)
end

function love.keyreleased(key)
    input:keyreleased(key)
end

function love.mousepressed(x, y, button)
    input:mousepressed(button)
end

function love.mousereleased(x, y, button)
    input:mousereleased(button)
end

function love.gamepadpressed(joystick, button)
    input:gamepadpressed(joystick, button)
end

function love.gamepadreleased(joystick, button)
    input:gamepadreleased(joystick, button)
end

function love.gamepadaxis(joystick, axis, value)
    input:gamepadaxis(joystick, axis, value)
end
