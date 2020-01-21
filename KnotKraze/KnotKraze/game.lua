function menu()
	--Title
	love.graphics.setColor(0, 0, 1)
	love.graphics.print("KnotKraze", 265, 100, 0, 3)
	
	--Start Button
	love.graphics.rectangle("line", 265, 200, 60, 25)
	love.graphics.print("Start", 280, 205)
	--Check if clicked to start game
	if(love.mouse.getX() > 265 and love.mouse.getX() < 325 and
				love.mouse.getY() > 200 and love.mouse.getY() < 225
				and love.mouse.isDown(1)) then
		startGame = true
		love.graphics.setColor(1, 1, 1)
	end
	
	--Exit Button
	love.graphics.rectangle("line", 390, 200, 60, 25)
	love.graphics.print("Exit", 408, 205)
	--Check if clicked to exit game
	if(love.mouse.getX() > 390 and love.mouse.getX() < 450 and
				love.mouse.getY() > 200 and love.mouse.getY() < 225
				and love.mouse.isDown(1)) then
		love.event.quit()
	end
end

function gameStart()
	--Draw Game Scene
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(scene, 0, 0)
	love.graphics.draw(chair, 120, 330, 0, 0.35, 0.5)
	love.graphics.draw(hair, 240, 100, 0, 0.55, 0.55)
	
	--Draw Timer and Score
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("line", 540, 30, 150, 70)
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", 540, 30, 150, 70)
	love.graphics.setColor(0, 0, 0)
			
	---Timer
	if(timeTicks % 30 == 0) then
		timer = timer - 1
	end
	timerString = timer
	if(timer <= 10) then
		love.graphics.setColor(1, 0, 0)
	end
		
	love.graphics.print("Time: "..timer, 550, 40, 0, 1.5)
	love.graphics.setColor(0, 0, 0)
	
	if(timer == 0) then
		lose = true
		gameOver()
	end
	
	---Score
	love.graphics.print("Score: "..score, 550, 68, 0, 1.5)
	
	--Check For a Knot
	if(knotExists and lose == false) then
		drawKnot(position)
	end
	
	knotTicks = knotTicks + 1
	timeTicks = timeTicks + 1
	
	if(knotExists == false) then
	--	love.graphics.print("Knot Gone!", 300, 300, 0, 2)
		score = score + 1
	end
end

function generateKnot()
	knotExists = true
	knotTicks = 0
	position = love.math.random(6)
	
	if(position == 1) then		--top left
		key = "1"
		end
	if (position == 2) then	--top right
		key = "2"
		end
	if (position == 3) then	--mid left
		key = "3"
		end
	if (position == 4) then	--mid right
		key = "4"
		end
	if (position == 5) then	--bottom left
		key = "5"
		end
	if (position == 6) then						--bottom right
		key = "6"
	end
end

function drawKnot(position)
	love.graphics.setColor(1, 1, 1)
	if(position == 1) then		--top left
		love.graphics.draw(knot, 250, 125, 0, knotScale, knotScale)
		end
	if (position == 2) then	--top right
		love.graphics.draw(knot, 350, 125, 0, knotScale, knotScale)
		end
	if (position == 3) then	--mid left
		love.graphics.draw(knot, 250, 200, 0, knotScale, knotScale)
		end
	if (position == 4) then	--mid right
		love.graphics.draw(knot, 350, 200, 0, knotScale, knotScale)
		end
	if (position == 5) then	--bottom left
		love.graphics.draw(knot, 250, 300, 0, knotScale, knotScale)
		end
	if (position == 6) then						--bottom right
		love.graphics.draw(knot, 350, 300, 0, knotScale, knotScale)
	end
end

function gameOver()
	--Show Game Over Screen
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", 265, 190, 200, 60)
	love.graphics.setColor(0, 0, 0)
	love.graphics.print("Final Score: "..score, 280, 200, 0, 2)
	if(love.mouse.isDown(1)) then
	--Update values
	startGame = false
	timer = 91
	timeTicks = 0
	score = 0
	menu()
	end
end