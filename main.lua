

Mode = "draw"
BackgroundColor = "white"
DrawColor = "red"
WindowWidth = love.graphics.getWidth()
WindowHeight = love.graphics.getHeight()
CellSize = 50
Pixels = {}
ColorIcons = {}
Colors = {
        ["white"]={1, 1, 1, 1},
        ["black"]={0, 0, 0, 1},
        ["red"]={1, 0, 0, 1},
        ["green"]={0, 1, 0, 1},
        ["blue"]={0, 0, 1, 1}
    }

function love.load()
    for i=0,16,1 do
        Pixels[i] = {}
        for j=0,16,1 do
            local xp = i * CellSize + 200
            local yp = j * CellSize
            Pixels[i][j] = {x=xp, y=yp, color=BackgroundColor, background=true}
        end
    end
end

function love.update(dt)
    if love.mouse.isDown(1) and Mode == "draw" then 
        local mouse_x, mouse_y = love.mouse.getPosition()
        for i=0, 16, 1 do 
            for j=0, 16, 1 do
                local px = Pixels[i][j].x
                local py = Pixels[i][j].y
                if mouse_x > px and mouse_x < px + CellSize and mouse_y > py and mouse_y < py + CellSize then 
                    Pixels[i][j].color = DrawColor
                    Pixels[i][j].background = false
                end 
            end
        end 
        
    end 
end

function love.draw()
    for i=0, 16, 1 do 
        for j=0, 16, 1 do
            love.graphics.setColor(Colors[Pixels[i][j].color])
            love.graphics.rectangle("fill", Pixels[i][j].x, Pixels[i][j].y, CellSize, CellSize)
        end 
    end 
    local i = 0
    for name, value in pairs(Colors) do 
        local x = ((i % 4) * CellSize)
        local y = (math.floor(i / 4) * CellSize)
        love.graphics.setColor(value)
        love.graphics.rectangle("fill", x, y, CellSize, CellSize)
        i = i + 1
    end 
end 

function love.mousepressed(x, y, button)

end 