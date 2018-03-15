require("src/core/init")

local anims = {}
x,y = w/2,h/2

function love.load()
    local utf8 = require("utf8")
    love.graphics.setFont(love.graphics.newFont("src/console/simhei.ttf",12))
    input = Input()
    local font = love.graphics.getFont()
    love.graphics.setDefaultFilter( 'nearest', 'nearest' )
    camera = Camera()
    camera.draw_deadzone = true
    camera:setFollowStyle('LOCKON')
    -- camera:setDeadzone(100, h/2, w - 200,100)
    camera:setFollowLerp(0.2)
    camera:setFollowLead(5)
    -- image = love.graphics.newImage('1945.png')
    image = love.graphics.newImage('res/caverman.png')
    local g = anim8.newGrid(97,71,582,497,0,0,1)
    idle = anim8.newAnimation(g('1-6',1),0.13)
    walk = anim8.newAnimation(g('1-6',2,'1-2',3),0.08)
    climb = anim8.newAnimation(g('1-4',7),0.18)
    table.insert(anims,idle)
    table.insert(anims,walk)
    table.insert(anims,climb)
end

function love.draw()
 	camera:attach()
 	for i=1,#anims do
 		anims[i]:draw(image,97*i,71)
 	end
 	camera:detach()
    camera:draw()
    love.graphics.print(("x=%f, y=%f"):format(x,y), 30,30)
end

function love.update(dt)
	for i=1,#anims do
 		anims[i]:update(dt)
 	end
	camera:update(dt)
	love.graphics.print(("dt=%f"):format(dt), 50,50)
    if love.keyboard.isDown('up') or love.keyboard.isDown('w') then y = y - dt*200 end
  	if love.keyboard.isDown('down') or love.keyboard.isDown('s') then y = y + dt*200 end
  	if love.keyboard.isDown('right') or love.keyboard.isDown('d')then x = x + dt*200 end
  	if love.keyboard.isDown('left') or love.keyboard.isDown('a') then x = x - dt*200 end
	camera:follow(x, y)
end

function love.keypressed(key)
    if (key == '`') then 
        console.Show()
    end
  	if key == 'escape' then love.event.quit() end
    if key == 'f' then
        camera:flash(0.2)
    end
end
