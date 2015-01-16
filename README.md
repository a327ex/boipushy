# Thomas

An input module for LÖVE. Simplifies input handling by abstracting them away to actions,
enabling pressed/released checks outside of LÖVE's callbacks and taking care of gamepad input as well.

## Usage

The [module](https://github.com/adonaac/thomas/blob/master/Input.lua) and the 
[gamecontrollerdb.txt](https://github.com/adonaac/thomas/blob/master/gamecontrollerdb.txt) file should be dropped 
on your project and required like so:

```lua
Input = require 'Input'
```

An object is returned and from that you can create multiple input objects.

### Creating an input object

For each input object you need to add it to some of LÖVE's callbacks:

```lua
function love.load()
  input = Input()
end

function love.update(dt)
  -- add your stuff here!!!
  -- input call must come after everything
  -- or pressed/released on update won't work
  input:update(dt)
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
```

### Binding keys to actions

```lua
input:bind('1', 'print')
input:bind('s', function() print(2) end)
input:bind('mouse1', 'left_click')
```

### Checking if an action is pressed/released/down

```lua
function love.update(dt)
  if input:pressed('print') then print(1) end
  if input:released('print') then print(2) end
  if input:down('left_click') then print('left click down') end

  input:update(dt)
end
```

### Unbinding a key

```lua
input:unbind('1')
input:unbind('s')
input:unbind('mouse1')
```

### Key/mouse/gamepad Constants

Keyboard constants are unchanged from [here](https://www.love2d.org/wiki/KeyConstant), but mouse and gamepad have been changed to the following:

```lua
-- Mouse
'mouse1'
'mouse2'
'mouse3'
'mouse4'
'mouse5'
'wheelup'
'wheeldown'

-- Gamepad
'fdown' -- fdown/up/left/right = face buttons: a, b...
'fup'
'fleft'
'fright'
'back'
'guide'
'start'
'leftstick' -- left stick pressed or not (boolean)
'rightstick' -- right stick pressed or not (boolean)
'l1'
'r1'
'l2' -- returns a value from 0 to 1
'r2' -- returns a value from 0 to 1
'dpup' -- dpad buttons
'dpdown'
'dpleft'
'dpright'
'leftx' -- returns a value from -1 to 1, the left stick's horizontal position
'lefty' -- same for vertical
'rightx' -- same for right stick
'righty'
```

### LICENSE

You can do whatever you want with this. See the [LICENSE](https://github.com/adonaac/thomas/blob/master/LICENSE).
