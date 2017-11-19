# boipushy

An input module for LÖVE. Simplifies input handling by abstracting them away to actions,
enabling pressed/released checks outside of LÖVE's callbacks and taking care of gamepad input as well. :)

<br>

## Usage

```lua
Input = require 'Input'
```

<br>

### Creating an input object

```lua
function love.load()
  input = Input()
end
```

You can create multiple input objects even though you can get by most of the time with just a single global one. If your game supports multiple players locally then it's probably a good idea to create a different input object for each player, although it's not necessary as long as bindings between players don't collide.

<br>

### Binding keys to actions

```lua
input:bind('1', 'print')
```

The example above binds the `'1'` key to the `'print'` action. This means that in our code we can check for the `'print'` action being pressed with `input:pressed('print')`, for instance, and that function would return true on the frame that we pressed the `'1'` key on the keyboard. This layer of indirection between keyboard and action allows our gameplay focus to only speak in terms of actions, which means that it doesn't have to care about which method of input is being used or if the key bindings were changed to something else.

```lua
input:bind('s', function() print(2) end)
input:bind('mouse1', 'left_click')
```

On top of action strings we can also bind anonymous functions. In this case, whenever we press the `'s'` key on the keyboard `2` would be printed to the console. Additionally, we can bind mouse and gamepad buttons in the same.

<br>

### Checking if an action is pressed/released/down

```lua
function love.update(dt)
  if input:pressed('print') then print('The 1 key was pressed on this frame!') end
  if input:released('print') then print('The 1 key was released on this frame!') end
  if input:down('left_click') then print('The left mouse button is being held down!') end
end
```

`pressed`, `released` and `down` are the main functions of the library. Both `pressed` and `released` only return true on the frame when that event happened, while `down` returns true on every frame that the key bound to the action is being held down.

<br>

### Triggering events on intervals if an action is held down

The `down` function can accept additional arguments to trigger events on an interval basis. For instance:

```lua
function love.update(dt)
  if input:down('print', 0.5) then print(love.math.random()) end
end
```

The example above will print a random number every 0.5 seconds from when the `'print'` action key was held down. This is useful in a number of situations, like if you want your player to be able to only perform some action (like shooting projectiles) according to some cooldown.

Additionally, a third argument can be passed which represents a delay for the event triggering to start. For instance:

```lua
function love.update(dt)
  if input:down('print', 0.5, 2) then print(love.math.random()) end
end
```

The example above will print a random number every 0.5 seconds after 2 seconds have passed from when the `'print'` action key was held down. This behavior can be seen in action whenever you're typing something and you hold a key down, for instance. If you hold the `x` key down, first `x` will be typed once, there will be a small amount of time (like say 0.3s) where nothing happens, and then a lot of `x` will come following really fast. 

<br>

### Sequences

The `sequence` function allows you to check for sequences of buttons pressed within an interval of each other. For instance:

```lua
function love.update(dt)
  if input:sequence('right', 0.5, 'right') then
    -- dash right
  end
end
```

In the example above the `sequence` function will return true when the `'right'` action is pressed twice, and the second key press happened within 0.5s of the first. This is useful for simple things like dashing, but also for more complex sequences like combos. This function must be started and finished with an action, and between each action there should be the interval limit.

<br>

### Unbinding a key

```lua
input:unbind('1')
input:unbind('s')
input:unbind('mouse1')
```

Unbinding keys simply disconnects them from their actions. You can also use `input:unbindAll()` to unbind all bound keys.

<br>

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

<br>

### LICENSE

You can do whatever you want with this. See the license at the top of the main file.
