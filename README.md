# Animations

## Description

Create animations in Löve2d easily with this small library. Read the documentation for using the functionalities.

The library was made following the [Löve2D animation tutorial](https://love2d.org/wiki/Tutorial:Animation).

> Of course you have to add the file 'Animation.lua' in your project, remember to add the 'require' statement too.

---

## Overview

| Methods	| Description				| Required parameters				| Returns		|
| -:		| ------------------------------------- | --------------------------------------------- | --------------------- |
| new()		| Creates a new animation (Constructor)	| image_or_path, sprite_width, sprite_height	| Animation		|
| update()	| Updates the animation			| delta_time					| null (nothing)	|
| draw()	| Draws the animation			| x_position, y_position			| null (nothing)	|
| start()	| Starts the animation	(see more)	|						| null (nothing)	|
| stop()	| Stops the animation (see more)	|						| null (nothing)	|
| restart()	| Restarts the animation (from frame 0)	|						| null (nothing)	|
| setScale()	| Sets the animation scale		| new_scale					| null (nothing)	|
| addCallback()	| Adds a callback in the desired frame	| frame_index, function				| null (nothing)	|




## Creating an animation

```Animation:new(image_or_path, sprite_width, sprite_height)```  Minimum required

```Animation:new(image_or_path, sprite_width, sprite_height, animation_duration, loop, x_offset, y_offset)```

* **image_or_path**: An image object (love.graphics.newImage(imagePath)) or the path to the image. The image have to be a spritesheet with all the sprites in the same row, see the *oldHero.png*.
* **sprite_width**: The width of the sprite.
* **sprite_height**: The height of the sprite.
* **animation_duration**: The duration of the animation, when lower, quicker the animation (default is 1 second).
* **loop**: True if the animation have to loop, false if not (default is false).
* **x_offet**: The x offset (default is the sprite_width / 2).
* **y_offet**: The y offset (default is the sprite_height / 2).

### Creating an animation example:

```lua
img = love.graphics.newImage("oldHero.png") -- Sprite size --> 16 x 18
animation = Animation:new(img, 16, 18, 0.5, true)

-- YOU CAN PASS AS ARGUMENT AN IMAGE OR THE PATH TO THE IMAGE, the result is the same.

animation = Animation:new("oldHero.png", 16, 18, 0.5, true)
```

---

## Updating the animation

```Animation:update(dt)```

* **dt**: Delta time, time between two frames. Use love.update(dt). You can get it by calling love.timer.getDelta() too.

---

## Drawing the animation

```Animation:draw(x, y)```

* **x**: The x position where the animation have to be drawn.
* **y**: The y position where the animation have to be drawn.

> If x_offset and y_offset were ignored (default) the animation will be centered.

---

## Starting the animation

```Animation:start()```

> If the animation is stopped and then started, it will continue. Won't be restarted, see (Restarting the animation).

---

## Stopping the animation

```Animation:stop()``` Minimum required

```Animation:stop(n_frame)```

* **n_frame**: The frame (sprite) that the animation will mantain after stopped (int)

---

## Restarting the animation

```Animation:restart()```

> By restarting the animation you make sure that the animation starts from frame zero.

---

## Changing the scale

```Animation:setScale(new_scale)```

* **new_scale**: New animation scale

---

## Adding callbacks

```Animation:addCallback(n_frame, function)```

> Every time the animation reaches the frame *n_frame*, function will be called.

* **n_frame**: The frame in wich the function will be called.
* **function**: The called function.

### Adding callbacks example

```lua

function notice()
	print("I am called in the frame 5!!")
end

animation:addCallback(5, notice)

-- THE SAME, SHORTER

animation:addCallback(5, function() print("I am called in the frame 5!!") end)

```

# Example

```lua
-- main.lua

local Animation = require 'Animation'


function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest") -- Not necessary, sets the correct filter for loading pixelart images.

	local img = love.graphics.newImage("oldHero.png") -- Sprite size --> 16 x 18
	myAnimation = Animation:new(img, 16, 18, 0.5, true) -- The animation takes 0.5 seconds and loops until myAnimation:stop()
	myAnimation:setScale(8) -- The drawn image is 8 times bigger than the real size.
	myAnimation:addCallback(5, function() print("I am called in the frame 5!!") end) -- Each time the animation reaches the 5 frame, this function is called.

	myAnimation:start() -- Starts the animation.
end



function love.update(dt)
	myAnimation:update(dt) -- Remember the update and the draw!!
end


function love.draw()
	myAnimation:draw(200, 200) -- Remember the update and the draw!!
end
```
