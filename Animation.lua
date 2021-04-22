local Animation = {}

-- Image is an spritesheet with all the sprites in the same row
function Animation:new(image_or_path, width, height, duration, loop, ox, oy)
	local a = a or {}

	if type(image_or_path) == 'string' then
		image_or_path = love.graphics.newImage(image_or_path)
	elseif type(image_or_path) ~= 'userdata' then
		print("ERROR: first argument of Animation:new() must to be an image (love.graphics.newImage(path)) or a path to the image")
		return
	end

	a.duration = duration or 1
	a.currentTime = 0
	a.playing = false
	a.previousFrame = 0 -- It is 0 only in the begining for checking the callbacks in all frame changes, including the first one
	a.loop = loop or false
	a.spriteSheet = image_or_path
	a.quads = {}
	a.callbacks = {}
	a.currentFrame = 1
	a.scale = 1
	a.ox = ox or math.floor(width / 2)
	a.oy = oy or math.floor(height / 2)
	
	
	
	local imgWidth, imgHeigth = a.spriteSheet:getDimensions()

	for y = 0, imgHeigth - height, height do
		for x = 0, imgWidth - width, width do
			table.insert(a.quads, love.graphics.newQuad(x, y, width, height, imgWidth, imgHeigth))
		end
	end

	setmetatable(a, self)
	self.__index = self
	return a
end

function Animation:start()
	self.playing = true
end

function Animation:restart()
	self.playing = true
	self.currentTime = 0
	self.previousFrame = 0
end

function Animation:stop(defaultFrame)
	if defaultFrame then
		self.currentTime = (defaultFrame - 1) * self.duration / #self.quads
	end
	self.playing = false
end

function Animation:update(dt)
	if self.playing then

		self.currentTime = self.currentTime + dt
		if self.currentTime >= self.duration and self.loop then
			self.currentTime = self.currentTime - self.duration
		elseif self.currentTime >= self.duration then
			self:stop(1) -- first frame is the default frame
		end

		local spriteNum = math.floor(self.currentTime / self.duration * #self.quads) + 1
		if spriteNum ~= self.previousFrame then
			for i, callback in ipairs(self.callbacks) do
				if callback.frame == spriteNum then
					callback.func()
				end
			end
			self.previousFrame = spriteNum
		end
	end
end

function Animation:draw(x, y)
	local spriteNum = math.floor(self.currentTime / self.duration * #self.quads) + 1
    love.graphics.draw(self.spriteSheet, self.quads[spriteNum], x, y, 0, self.scale, self.scale, self.ox, self.oy)
end

function Animation:addCallback(nFrame, func)
	table.insert(self.callbacks, {frame = nFrame, func = func})
end

function Animation:setScale(s)
	self.scale = s
end

function Animation:load(path, w, h, duration, loop, engageSizeW, engageSizeH) -- ox, oy

	assert(path, "ERROR: Animation:load(path, ...), path have to be a string")
	
	-- anim_w64h64d1l1s1
	w = w or tonumber(path:match("(w%d+)"):sub(2))
	h = h or tonumber(path:match("(h%d+)"):sub(2))
	assert(w, h, "ERROR: Animation:load(path, w, h, ...), Requires a non nil width and height (the individual sprite size)")
	if not duration then
		duration = path:match("(d%d+)")
		if duration then duration = tonumber(duration:sub(2)) else duration = 1 end
	end
	if loop == nil then
		loop = path:match("(l%d+)")
		if loop then loop = tonumber(loop:sub(2)) if loop == 1 then loop = true else loop = false end else loop = false end
	end
	--ox = ox or tonumber(path:match("(ox%d+)"):sub(3)) or nil -- IF YOU NEED TO USE THIS CODE (OX and OY parameters), WRITE IT AS ABOVE
	--oy = oy or tonumber(path:match("(oy%d+)"):sub(3)) or nil

	local a = self:new(path, w, h, duration, loop, 0, 0) -- ox, oy
	if loop then a:start() end

	
	local scale
	if engageSizeW then
		scale = engageSizeW / w
	elseif engageSizeH then
		scale = engageSizeH / h
	else
		scale = 1
	end
	a:setScale(scale)
	return a
end

function Animation:loadFromTable(path, data)

	local a = Animation:load(path, nil, nil, data.duration, data.loop, data.ox, data.oy)
	a:setScale(data.scale)
	a.previousFrame = data.previousFrame
	a.playing = data.playing
	a.currentFrame = data.currentFrame
	a.currentTime = data.currentTime
	
	--DO NOT SUPPORT CALLBACKS, YOU HAVE TO ADD THE CALLBACKS AFTER LOADING THE ANIMATION

	return a
end

return Animation
