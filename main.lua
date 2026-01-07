Mode = "draw"
BackgroundColor = {name="white", rgba={1, 1, 1, 1}}
DrawColor = {name="black", rgba={0, 0, 0, 1}}
WindowWidth = love.graphics.getWidth()
WindowHeight = love.graphics.getHeight()
CellSize = 50
Pixels = {}
ColorIcons = {}
Colors = {
    {name="white", rgba={1, 1, 1, 1}},
    {name="black", rgba={0, 0, 0, 1}},
    {name="red", rgba={1, 0, 0, 1}},
    {name="green", rgba={0, 1, 0, 1}},
    {name="blue", rgba={0, 0, 1, 1}},
}
Actions = {}

function love.load()
    for i=0,16,1 do
        Pixels[i] = {}
        for j=0,16,1 do
            local xp = i * CellSize + 200
            local yp = j * CellSize
            Pixels[i][j] = {x=xp, y=yp, color=BackgroundColor, background=true}
        end
    end
    for i, v in ipairs(Colors) do 
        local x = (((i-1) % 4) * CellSize)
        local y = (math.floor((i-1) / 4) * CellSize)
        ColorIcons[i] = {x=x, y=y, color=v}
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
                    if (Pixels[i][j].color ~= DrawColor) then 
                        table.insert(Actions, 1, {color=Pixels[i][j].color, background=Pixels[i][j].background, i=i, j=j})
                    end 
                    Pixels[i][j].color = DrawColor
                    Pixels[i][j].background = false
                end 
            end
        end 
        for _, v in ipairs(ColorIcons) do
            if mouse_x > v.x and mouse_x < v.x + CellSize and mouse_y > v.y and mouse_y < v.y + CellSize then 
                DrawColor = v.color
            end 
        end 
    end 

    if love.mouse.isDown(2) then 
        local mouse_x, mouse_y = love.mouse.getPosition()
        local set_background = false
        for _, v in ipairs(ColorIcons) do
            if mouse_x > v.x and mouse_x < v.x + CellSize and mouse_y > v.y and mouse_y < v.y + CellSize then 
                BackgroundColor = v.color
                set_background = true
            end 
        end 
        for i=0, 16, 1 do 
            for j=0, 16, 1 do
                local px = Pixels[i][j].x
                local py = Pixels[i][j].y
                if mouse_x > px and mouse_x < px + CellSize and mouse_y > py and mouse_y < py + CellSize then 
                    Pixels[i][j].color = BackgroundColor
                    Pixels[i][j].background = true
                end 
                if set_background and Pixels[i][j].background == true then 
                    Pixels[i][j].color = BackgroundColor
                end 
            end
        end 
    end 
end

function love.draw()
    for i=0, 16, 1 do 
        for j=0, 16, 1 do
            love.graphics.setColor(Pixels[i][j].color.rgba)
            love.graphics.rectangle("fill", Pixels[i][j].x, Pixels[i][j].y, CellSize, CellSize)
        end 
    end 
    for _, v in ipairs(ColorIcons) do 
        love.graphics.setColor(v.color.rgba)
        love.graphics.rectangle("fill", v.x, v.y, CellSize, CellSize)
        love.graphics.setColor({0, 0, 0, 1})
        love.graphics.rectangle("line", v.x, v.y, CellSize, CellSize)
    end
end 

function love.mousepressed(x, y, button)

end

function love.keypressed(key, scancode, isrepeat)
    if key == "z" then 
        if #Actions > 0 then 
            local latest_action = table.remove(Actions, 1)
            Pixels[latest_action.i][latest_action.j].color = latest_action.color
            Pixels[latest_action.i][latest_action.j].background = latest_action.background
        end 
    end 
end

