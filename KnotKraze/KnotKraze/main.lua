require "game"

window = love.window.setMode(728, 410)
love.window.setTitle("KnotKraze")

function love.load()
	--Game Assets
	scene = love.graphics.newImage("background.png")
	hair = love.graphics.newImage("hair.png")
	chair = love.graphics.newImage("seat.png")
	knot = love.graphics.newImage("knot.png")
	
	--Starting Knot Size
	knotScale = 0.25
	position = 0
	key = "0"
	
	--Number of Frames Passed by
	timeTicks = 0
	knotTicks = 0
	
	--Score and Timer values
	timer = 91
	score = 0
	
	--Boolean values for draw triggers
	startGame = false
	
	knotExists = false
	paused = false
	lose = false
end

function love.update(dt)
	if(timer == 0) then				--USE THIS PLACE FOR GAME OVER SCREEN
		love.timer.sleep(10)
		love.event.quit()
	end
	if(knotExists == false) then
		generateKnot()
	end
	
	shrinkKnot(knotTicks, key)
end

function love.draw()
	if(startGame) then
		gameStart()
	else
		menu()
	end
end

function shrinkKnot(knotTicks, key)
	if(love.keyboard.isDown(key) and knotTicks > 30) then
		knotScale = knotScale - 0.008
		knotTicks = 0
	end
	if(knotScale <= 0) then
		knotExists = false
		knotScale = 0.25
	end
end