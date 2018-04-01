Camera = require 'camera'


local player = {x=0,y=0,vx=0,vy=0,speed=50,dir=1}

local forest = {}

function love.load()
    Stree = love.graphics.newImage("tree.png")
    Scat = love.graphics.newImage("cat.png")
    camera = Camera()
    camera:setFollowLerp(0.2)
    camera:setFollowStyle('SCREEN_BY_SCREEN')
    --camera:setFollowLead(10)-- will use for sprinting?
    
    for i=0, 100 do
       forest[i]= {x=math.random(-1000,1000),y=math.random(-1000,1000)} 
    end
end

function moveplayer(dt)
    if love.keyboard.isDown("w") then
        player.vy = player.vy - dt * player.speed
    elseif love.keyboard.isDown("s") then
        player.vy = player.vy + dt * player.speed
    end

    if love.keyboard.isDown("a") then
        player.vx = player.vx - dt * player.speed
        player.dir = -1
    elseif love.keyboard.isDown("d") then
        player.vx = player.vx + dt * player.speed
        player.dir = 1
    end

    player.x = player.x + player.vx
    player.y = player.y + player.vy
    player.vx = player.vx/1.1
    player.vy = player.vy/1.1
end

function love.update(dt)
    camera:update(dt)
    camera:follow(player.x, player.y)
    moveplayer(dt)

end

function love.draw()
    camera:attach()
    -- Draw your game here
    love.graphics.print(math.floor(player.x)..":"..math.floor(player.y),player.x,player.y-32)
    love.graphics.draw(Scat, player.x, player.y,0,player.dir,1)
    --love.graphics.rectangle("fill", player.x, player.y, 25, 25)
    for i, v in pairs(forest) do
        love.graphics.draw(Stree, v.x, v.y)
    end
    
    camera:detach()
    camera:draw() -- Call this here if you're using camera:fade, camera:flash or debug drawing the deadzone
end