love.graphics.setBackgroundColor(.5, .5, .75)


function love.load()
	Object = require "classic"
	require "Box"
	boxes = Box()
	
	-- Score Keeper
	totalScore = 0
	strikes = 3
	
	-- Timing Variables
	beginning = true
	firstTime = true
	faster = false
	startTime = 32
	pitch = 1.2
	kick = 0
	speed = 150
	
	-- Counts to determine where to start drawing
	headCount = 0
	shoulderCount = 0
	kneeCount = 0
	knee2Count = 0
	toeCount = 0
	toe2Count = 0
	
	-- X positions for Boxes
	HXPos = 50
	SXPos = 175
	KXPos = 300
	TXPos = 425
	
	-- Y positions for Boxes
	HYPos = 1300
	SYPos = 1425
	KYPos = 1500
	K2YPos = 1750
	TYPos = 1600
	T2YPos = 1850

	-- Y position for Outlines
	constYPos = 50
	
	-- Songs
	song = love.audio.newSource("hskt.mp3", "static")
	secondSong = love.audio.newSource("hsktOnly.mp3", "static")
	start = love.timer.getTime()
	song:play()
end

function love.update(dt)
	if(strikes <= 0)
	then
		score = "Final Score: " .. tostring(totalScore)
		love.audio.stop()
		love.timer.sleep(5)
		love.event.quit()
	end

	-- If beginning, play first song else play second song
	if(beginning)
	then
		song:play()
		beginning = false
	elseif(love.timer.getTime() - start >= startTime and firstTime)
	then
		secondSong:play()
		secondSong:setPitch(pitch)
		start = love.timer.getTime()
		firstTime = false
		speed = speed + (speed *0.15)
	elseif(love.timer.getTime() - start > (secondSong:getDuration() - 4 - kick) and firstTime == false)
	then
		kick = kick + 2.1
		secondSong:play()
		pitch = pitch + 0.2
		secondSong:setPitch(pitch)
		speed = speed + (speed *0.15)
		start = love.timer.getTime()
	end
	
	-- If a box is off the screen, stop drawing it and a strike
	if(HYPos < -100)
	then
		strikes = strikes - 1
		headCount = headCount + 1
		if(headCount == 2 or headCount == 3)
		then
			HYPos = 1500
			if(headCount == 3)
			then
				headCount = 0
			end
		else
			HYPos = 750
		end
	elseif(SYPos < -100)
	then
		strikes = strikes - 1
		shoulderCount = shoulderCount + 1
		if(shoulderCount == 2 or shoulderCount == 3)
		then
			SYPos = 1510
			if(shoulderCount == 3)
			then
				shoulderCount = 0
			end
		else
			SYPos = 750
		end
	elseif(KYPos < -100)
	then
		strikes = strikes - 1
		kneeCount = kneeCount + 1
		if(kneeCount == 2 or kneeCount == 3)
		then
			KYPos = 1525
			if(kneeCount == 3)
			then
				kneeCount = 0
			end
		else
			KYPos = 750
		end
	elseif(TYPos < -100)
	then
		strikes = strikes - 1
		toeCount = toeCount + 1
		if(toeCount == 2 or toeCount == 3)
		then
			TYPos = 1540
			if(toeCount == 3)
			then
				toeCount = 0
			end
		else
			TYPos = 750
		end
	elseif(K2YPos < -100)
	then
		strikes = strikes - 1
		knee2Count = knee2Count + 1
		if(knee2Count == 2 or knee2Count == 3)
		then
			K2YPos = 1550
			if(knee2Count == 3)
			then
				knee2Count = 0
			end
		else
			K2YPos = 750
		end
	elseif(T2YPos < -100)
	then
		strikes = strikes - 1
		toe2Count = toe2Count + 1
		if(toe2Count == 2 or toe2Count == 3)
		then
			T2YPos = 1560
			if(toe2Count == 3)
			then
				toe2Count = 0
			end
		else
			T2YPos = 750
		end
	end

	-- Check for User Keystrokes
	if(love.keyboard.isDown("h") and (HYPos >= 25 and HYPos <= 150))
	then
		headCount = headCount + 1
		if(headCount == 2 or headCount == 3)
		then
			HYPos = 1500
			if(headCount == 3)
			then
				headCount = 0
			end
		else
			HYPos = 750
		end
		totalScore = totalScore + 1
	elseif(love.keyboard.isDown("s") and (SYPos >= 25 and SYPos <= 150))
	then
		shoulderCount = shoulderCount + 1
		if(shoulderCount == 2 or shoulderCount == 3)
		then
			SYPos = 1510
			if(shoulderCount == 3)
			then
				shoulderCount = 0
			end
		else
			SYPos = 750
		end
		totalScore = totalScore + 1
	elseif(love.keyboard.isDown("k") and (KYPos >= 25 and KYPos <= 150))
	then
		kneeCount = kneeCount + 1
		if(kneeCount == 2 or kneeCount == 3)
		then
			KYPos = 1525
			if(kneeCount == 3)
			then
				kneeCount = 0
			end
		else
			KYPos = 750
		end
		totalScore = totalScore + 1
	elseif(love.keyboard.isDown("k") and (K2YPos >= 25 and K2YPos <= 150))
	then
		knee2Count = knee2Count + 1
		if(knee2Count == 2 or knee2Count == 3)
		then
			K2YPos = 1550
			if(knee2Count == 3)
			then
				knee2Count = 0
			end
		else
			K2YPos = 750
		end
		totalScore = totalScore + 1
	elseif(love.keyboard.isDown("t") and (TYPos >= 25 and TYPos <= 150))
	then
		toeCount = toeCount + 1
		if(toeCount == 2 or toeCount == 3)
		then
			TYPos = 1540
			if(toeCount == 3)
			then
				toeCount = 0
			end
		else
			TYPos = 750
		end
		totalScore = totalScore + 1
	elseif(love.keyboard.isDown("t") and (T2YPos >= 25 and T2YPos <= 150))
	then
		toe2Count = toe2Count + 1
		if(toe2Count == 2 or toe2Count == 3)
		then
			T2YPos = 1560
			if(toe2Count == 3)
			then
				toe2Count = 0
			end
		else
			T2YPos = 750
		end
		totalScore = totalScore + 1
	end

	
	-- Shift remaining boxes upwards
	HYPos = HYPos - speed * dt
	SYPos = SYPos - speed * dt
	KYPos = KYPos - speed * dt
	K2YPos = K2YPos - speed * dt
	TYPos = TYPos - speed * dt
	T2YPos = T2YPos - speed * dt
end

function love.draw()
	
	-- Score and Strikes
	love.graphics.print("Score: "..tostring(totalScore), 600, 100, 0, 2)
	love.graphics.print("Chances Left: "..tostring(strikes), 550, 150, 0, 2)
	
	-- Box outlines on top of screen
	love.graphics.rectangle("line", HXPos, constYPos, 100, 100)
	love.graphics.rectangle("line", SXPos, constYPos, 100, 100)
	love.graphics.rectangle("line", KXPos, constYPos, 100, 100)
	love.graphics.rectangle("line", TXPos, constYPos, 100, 100)

	-- HSKT Boxes
	boxes:drawBox("head", HXPos, HYPos)
	boxes:drawBox("shoulders", SXPos, SYPos)
	boxes:drawBox("knees", KXPos, KYPos)
	boxes:drawBox("toes", TXPos, TYPos)
	boxes:drawBox("knees", KXPos, K2YPos)
	boxes:drawBox("toes", TXPos, T2YPos)
	
	if(strikes <= 0)
	then
		love.graphics.print("Final Score: "..tostring(totalScore), 300, 300, 0, 3)
	end
    
end