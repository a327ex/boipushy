# boipushy

An input module for LÖVE. Simplifies input handling by abstracting them away to actions,
enabling pressed/released checks outside of LÖVE's callbacks and taking care of gamepad input as well.

## Usage

```lua
Input = require 'Input'
```

### Creating an input object

```lua
function love.load()
  input = Input()
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
end
```

### Triggering events on intervals if an action is held down

```lua
function love.update(dt)
  -- Print a random number every 0.5 seconds from when the 'print' action key was held down
  if input:pressRepeat('print', 0.5) then print(love.math.random()) end
  
  -- Print a random number every 0.5 seconds after a 2 seconds delay 
  -- from when the 'print' action key was held down
  if input:pressRepeat('print', 0.5, 2) then print(love.math.random()) end
  
  -- Both versions of this function will return true immediately at the moment the key is held down once,
  -- so the output from the second call would be something like:
  -- >> random number
  -- wait 2 seconds
  -- >> random number
  -- wait 0.5 seconds
  -- >> random number
  -- wait 0.5 seconds
  -- ...
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
