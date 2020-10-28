-- main.lua

local Animation = require 'Animation'

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest") -- Not necessary, it is for scaling correctly pixelart images.

	local img = love.graphics.newImage("oldHero.png") -- Sprite size --> 16 x 18
	myAnimation = Animation:new(img, 16, 18, 0.5, true) -- The animation takes 0.5 seconds and loops until myAnimation:stop()
	myAnimation:setScale(8) -- The drawn image is 8 times bigger than the real size.
	myAnimation:addCallback(5, function() print("I am called in the frame 5!!") end) -- Each time the animation reaches the 5 frame, this function is called.
	myAnimation:start() -- Starts the animation.

	otherAnim = Animation:new(img, 16, 18, 0.5, false) -- The animation takes 0.5 seconds and loops until myAnimation:stop()
	otherAnim:setScale(5) -- The drawn image is 8 times bigger than the real size.
	otherAnim:addCallback(5, function() print("I am called in the frame 5!!") end) -- Each time the animation reaches the 5 frame, this function is called.
	otherAnim:start() -- Starts the animation.
end



function love.update(dt)
	myAnimation:update(dt) -- Remember the update and the draw!!
	otherAnim:update(dt)
	--otherAnim:setScale(dt * 500)
end


function love.draw()
	myAnimation:draw(200, 200) -- Remember the update and the draw!!
	otherAnim:draw(400, 200)
	otherAnim:draw(165, 377)
end
