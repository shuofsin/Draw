

Mode = "draw"
DrawColor = "white"
Width = love.graphics.getWidth()
Height = love.graphics.getHeight()
Pixels = {}
Colors = {
    white={1, 1, 1, 1},
    black={0, 0, 0, 1}
}

function love.load()
    for i=0, Width, 1 do 
        Pixels[i] = {}
        for j=0, Height, 1 do
        Pixels[i][j] = {color="black"}
        end 
    end
end

function love.update(dt)
    if love.mouse.isDown(1) and Mode == "draw" then
        local mouse_x, mouse_y = love.mouse.getPosition()
        Pixels[mouse_x][mouse_y]["color"] = DrawColor
    end 
end

function love.draw()
    for i=0, Width, 1 do
        for j=0, Height, 1 do
            love.graphics.setColor(Colors[Pixels[i][j]["color"]])
            love.graphics.points(i, j)
        end
    end
end 