# Animations

## Description

Create animations in Löve2d easily with this small library. Read the documentation for using the functionalities.

The library was made following the [Löve2D animation tutorial](https://love2d.org/wiki/Tutorial:Animation).

> Of course you have to add the file 'Animation.lua' in your project, remember to add the 'require' statement too.

---

## Functions


## Creating an animation

Required parameters:

```Animation:new(image_or_path, sprite_width, sprite_height)``` Returns an animation object, **indispensable**.

All parameters:

```Animation:new(image_or_path, sprite_width, sprite_height, animation_duration, loop, x_offset, y_offset)``` Returns an animation object.

* **image_or_path**: An image object (love.graphics.newImage(imagePath)) or the path to the image. The image have to be a spritesheet with all the sprites in the same row, see the image *oldHero.png*.
* **sprite_width**: The width of the sprite.
* **sprite_height**: The height of the sprite.
* **animation_duration**: The duration of the animation, when higher, quicker the animation (default is 1 second).
* **loop**: True if the animation have to loop, false if not (default is false).
* **x_offet**: The x offset (default is the sprite_width / 2).
* **y_offet**: The y offset (default is the sprite_height / 2).

### Examples:

```lua
img = love.graphics.newImage("oldHero.png") -- Sprite size --> 16 x 18
animation = Animation:new(img, 16, 18, 0.5, true)

-- YOU CAN PASS AS ARGUMENT AN IMAGE OR THE PATH TO THE IMAGE, the result is the same.

animation = Animation:new("oldHero.png", 16, 18, 0.5, true)
```

---

## Updating the animation

Required parameters:

```Animation:update(dt)``` Updates the animation, returns nothing, **indispensable**.

* **dt**: Delta time, time between two frames. Is the same parameter of love.update(dt). You can get it too by calling love.timer.getDelta()

---

## Drawing the animation

Required parameters:

```Animation:draw(x, y)``` Draws the animation, returns nothing, **indispensable**.

* **x**: The x position where the animation have to be drawn. If x_offset and y_offset were ignored (default) the animation will be well centered.
* **y**: The y position where the animation have to be drawn.

---

## Starting the animation

Requires no parameters:

```Animation:start()``` Starts the animation, returns nothing, **indispensable**.

---

## Stopping the animation

Requires no parameters:

```Animation:stop()``` Stops the animation, returns nothing.

Optional parameters:

```Animation:stop(n_frame)``` Stops the animation and lets the frame (sprite) n_frame

* **n_frame**: The frame (sprite) that the animation will mantain after stopped

---

## Reestarting the animation

Requires no parameters:

```Animation:restart()``` Restarts the animation, returns nothing.

> If you stop and then start the animation, the animation will continue, if the last frame (sprite) was the second one, then when start, the next frame will be the third. If you stopped the animation passing as an argument some frame, when start, the frame will be the next.
By restarting the animation you make sure that the animation starts from zero.

---

## Changing the scale

Required parameters:

```Animation:setScale(new_scale)``` Set the scale of the animation. Returns nothing

* **new_scale**: New scale of the animation

---

## Adding callbacks

Required parameters:

```Animation:addCallback(n_frame, function)``` Adds a function that is called when the animation reaches the frame n_frame. Returns nothing.

* **n_frame**: The frame in wich the function will be called.
* **function**: The called function.

### Examples

```lua

function notice()
	print("I am called in the frame 5!!")
end

animation:addCallback(5, notice)

-- THE SAME SHORTER

animation:addCallback(5, function() print("I am called in the frame 5!!") end)

```

# Example

```lua
-- main.lua

local Animation = require 'Animation'


function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest") -- Not necessary, it is for loading correctly pixelart images.

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
