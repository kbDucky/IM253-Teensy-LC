Box = Object:extend()
function Box:new()
	head = love.graphics.newImage("Head.png")
	shoulders = love.graphics.newImage("Shoulder.png")
	knees = love.graphics.newImage("Knees.png")
	toes = love.graphics.newImage("Toes.png")
end

function Box:drawBox(position, x, y)
	if(position == "head")
	then
		love.graphics.draw(head, x, y)
	elseif(position == "shoulders")
	then
		love.graphics.draw(shoulders, x, y)
	elseif(position == "knees")
	then
		love.graphics.draw(knees, x, y)
	elseif(position == "toes")
	then
		love.graphics.draw(toes, x, y)
	end
		
end