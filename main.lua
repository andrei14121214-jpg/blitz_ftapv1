local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(390, 300)
main.AnchorPoint = Vector2.new(0.5, 0.5)
-- НЕ ставим позицию сразу, установим после получения ViewportSize
main.BackgroundColor3 = Color3.fromRGB(30, 30, 33)
main.BorderSizePixel = 0
main.Parent = gui

-- Ждём реального размера экрана (даже в инжекторе)
local function updatePosition()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    if viewport.X > 0 and viewport.Y > 0 then
        main.Position = UDim2.new(0.5, 0, 0.5, 0)
        -- Дополнительно фиксируем через Tween, если гуи уже создано
        main:TweenPosition(UDim2.new(0.5, -195, 0.5, -150), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
    end
end

-- Вызов через task.wait() для гарантии загрузки камеры
task.spawn(function()
    while not workspace.CurrentCamera or workspace.CurrentCamera.ViewportSize.X == 0 do
        task.wait(0.1)
    end
    updatePosition()
end)

-- Перехват изменения размера окна (для ресайза в инжекторе)
local function onViewportChange()
    updatePosition()
end
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportChange)
