-- Roblox Auto Clicker Script (Optimized for High CPS)
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI Oluşturma
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoClickerGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 180)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Başlık (sürükleme alanı)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "⚡ ULTRA CLICKER ⚡ (Sürükle)"
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.Parent = mainFrame

-- CPS Göstergesi
local cpsLabel = Instance.new("TextLabel")
cpsLabel.Size = UDim2.new(0.6, 0, 0, 20)
cpsLabel.Position = UDim2.new(0, 5, 0, 30)
cpsLabel.BackgroundTransparency = 1
cpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
cpsLabel.Text = "HEDEF CPS: 100"
cpsLabel.Font = Enum.Font.Gotham
cpsLabel.TextSize = 11
cpsLabel.TextXAlignment = Enum.TextXAlignment.Left
cpsLabel.Parent = mainFrame

-- CPS Yazma Kutusu
local cpsTextBox = Instance.new("TextBox")
cpsTextBox.Size = UDim2.new(0.3, 0, 0, 20)
cpsTextBox.Position = UDim2.new(0.65, 0, 0, 30)
cpsTextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
cpsTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
cpsTextBox.Text = "100"
cpsTextBox.PlaceholderText = "CPS"
cpsTextBox.Font = Enum.Font.Gotham
cpsTextBox.TextSize = 11
cpsTextBox.Parent = mainFrame

-- ANLIK CPS Göstergesi
local realCpsLabel = Instance.new("TextLabel")
realCpsLabel.Size = UDim2.new(0.6, 0, 0, 20)
realCpsLabel.Position = UDim2.new(0, 5, 0, 50)
realCpsLabel.BackgroundTransparency = 1
realCpsLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
realCpsLabel.Text = "ANLIK CPS: 0"
realCpsLabel.Font = Enum.Font.Gotham
realCpsLabel.TextSize = 11
realCpsLabel.TextXAlignment = Enum.TextXAlignment.Left
realCpsLabel.Parent = mainFrame

-- Sabit Tıklama Butonu
local fixedClickButton = Instance.new("TextButton")
fixedClickButton.Size = UDim2.new(0.45, 0, 0, 20)
fixedClickButton.Position = UDim2.new(0.55, 0, 0, 50)
fixedClickButton.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
fixedClickButton.TextColor3 = Color3.fromRGB(255, 255, 255)
fixedClickButton.Text = "SABİT KONUM"
fixedClickButton.Font = Enum.Font.Gotham
fixedClickButton.TextSize = 9
fixedClickButton.Parent = mainFrame

-- Turbo Mod Butonu
local turboButton = Instance.new("TextButton")
turboButton.Size = UDim2.new(0.45, 0, 0, 20)
turboButton.Position = UDim2.new(0.55, 0, 0, 72)
turboButton.BackgroundColor3 = Color3.fromRGB(180, 100, 60)
turboButton.TextColor3 = Color3.fromRGB(255, 255, 255)
turboButton.Text = "TURBO MOD"
turboButton.Font = Enum.Font.Gotham
turboButton.TextSize = 9
turboButton.Parent = mainFrame

-- Başlat/Durdur Butonu
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.6, 0, 0, 30)
toggleButton.Position = UDim2.new(0.2, 0, 0, 95)
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "BAŞLAT (B)"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 12
toggleButton.Parent = mainFrame

-- Küçült Butonu (-)
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 25, 0, 20)
minimizeButton.Position = UDim2.new(0.8, 0, 0, 95)
minimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Text = "-"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 14
minimizeButton.Parent = mainFrame

-- Kapat Butonu (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 0, 20)
closeButton.Position = UDim2.new(0.9, 0, 0, 95)
closeButton.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 12
closeButton.Parent = mainFrame

-- Durum Göstergesi
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0, 130)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
statusLabel.Text = "🔴 DURUYOR"
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 10
statusLabel.Parent = mainFrame

-- Mod Bilgisi
local modeLabel = Instance.new("TextLabel")
modeLabel.Size = UDim2.new(1, 0, 0, 20)
modeLabel.Position = UDim2.new(0, 0, 0, 150)
modeLabel.BackgroundTransparency = 1
modeLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
modeLabel.Text = "Mod: Normal | Konum: Hareketli"
modeLabel.Font = Enum.Font.Gotham
modeLabel.TextSize = 9
modeLabel.Parent = mainFrame

-- Değişkenler
local isEnabled = false
local isGuiVisible = true
local isMinimized = false
local clickSpeed = 100
local connection
local clickCount = 0
local lastCpsUpdate = 0
local originalSize = mainFrame.Size
local minimizedSize = UDim2.new(0, 200, 0, 25)
local useFixedPosition = false
local turboMode = false
local fixedX, fixedY = 500, 300

-- Mouse pozisyonunu al
function getMousePosition()
    if useFixedPosition then
        return fixedX, fixedY
    else
        local mouse = player:GetMouse()
        return mouse.X, mouse.Y
    end
end

-- Optimize edilmiş tıklama fonksiyonu
function optimizedClick()
    local x, y = getMousePosition()
    
    if game:GetService("VirtualInputManager") then
        if turboMode then
            -- Turbo mod: Batch tıklama
            local batchSize = math.min(8, math.floor(clickSpeed / 100) + 1)
            for i = 1, batchSize do
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(x, y, 0, true, game, 1)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(x, y, 0, false, game, 1)
            end
            clickCount = clickCount + batchSize
        else
            -- Normal mod: Tekil tıklama
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(x, y, 0, true, game, 1)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(x, y, 0, false, game, 1)
            clickCount = clickCount + 1
        end
    end
end

-- Anlık CPS hesaplama
function updateRealCps()
    local currentTime = tick()
    if currentTime - lastCpsUpdate >= 0.3 then
        local realCps = math.floor((clickCount / 0.3) + 0.5)
        realCpsLabel.Text = "ANLIK CPS: " .. realCps
        clickCount = 0
        lastCpsUpdate = currentTime
    end
end

-- Yüksek performanslı auto clicker
function startOptimizedClicker()
    if connection then
        connection:Disconnect()
    end
    
    local targetInterval = 1 / clickSpeed
    local accumulatedTime = 0
    local lastFrameTime = tick()
    
    connection = RunService.Heartbeat:Connect(function()
        if not isEnabled then return end
        
        local currentTime = tick()
        local deltaTime = currentTime - lastFrameTime
        lastFrameTime = currentTime
        accumulatedTime = accumulatedTime + deltaTime
        
        if turboMode then
            -- Turbo mod: Sürekli tıklama
            local requiredClicks = math.floor(accumulatedTime / targetInterval)
            if requiredClicks > 0 then
                for i = 1, math.min(requiredClicks, 10) do
                    optimizedClick()
                end
                accumulatedTime = accumulatedTime - (requiredClicks * targetInterval)
            end
        else
            -- Normal mod: İnterval bazlı
            if accumulatedTime >= targetInterval then
                local multiClicks = math.floor(accumulatedTime / targetInterval)
                for i = 1, math.min(multiClicks, 3) do
                    optimizedClick()
                end
                accumulatedTime = accumulatedTime % targetInterval
            end
        end
        
        updateRealCps()
    end)
end

function stopAutoClicker()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

-- Auto Clicker'ı başlat/durdur
function toggleAutoClicker()
    isEnabled = not isEnabled
    
    if isEnabled then
        toggleButton.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
        toggleButton.Text = "DURDUR (B)"
        statusLabel.Text = "🟢 ÇALIŞIYOR - " .. clickSpeed .. " CPS"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        clickCount = 0
        lastCpsUpdate = tick()
        startOptimizedClicker()
    else
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        toggleButton.Text = "BAŞLAT (B)"
        statusLabel.Text = "🔴 DURUYOR"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        realCpsLabel.Text = "ANLIK CPS: 0"
        stopAutoClicker()
    end
end

-- Küçültme/Büyütme fonksiyonu
function toggleMinimize()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame.Size = minimizedSize
        mainFrame.Draggable = true
        cpsLabel.Visible = false
        realCpsLabel.Visible = false
        cpsTextBox.Visible = false
        fixedClickButton.Visible = false
        turboButton.Visible = false
        toggleButton.Visible = false
        minimizeButton.Visible = false
        closeButton.Visible = false
        statusLabel.Visible = false
        modeLabel.Visible = false
        title.Text = "⚡ ULTRA (" .. clickSpeed .. " CPS)"
        minimizeButton.Text = "+"
    else
        mainFrame.Size = originalSize
        mainFrame.Draggable = true
        cpsLabel.Visible = true
        realCpsLabel.Visible = true
        cpsTextBox.Visible = true
        fixedClickButton.Visible = true
        turboButton.Visible = true
        toggleButton.Visible = true
        minimizeButton.Visible = true
        closeButton.Visible = true
        statusLabel.Visible = true
        modeLabel.Visible = true
        title.Text = "⚡ ULTRA CLICKER ⚡ (Sürükle)"
        minimizeButton.Text = "-"
    end
end

-- GUI Etkileşimleri
cpsTextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newSpeed = tonumber(cpsTextBox.Text)
        if newSpeed and newSpeed >= 1 and newSpeed <= 2000 then
            clickSpeed = newSpeed
            cpsLabel.Text = "HEDEF CPS: " .. clickSpeed
            
            if isEnabled then
                stopAutoClicker()
                startOptimizedClicker()
            end
        else
            cpsTextBox.Text = tostring(clickSpeed)
        end
    end
end)

fixedClickButton.MouseButton1Click:Connect(function()
    useFixedPosition = not useFixedPosition
    if useFixedPosition then
        fixedClickButton.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
        fixedClickButton.Text = "SABİT ✓"
        -- Ekranın ortasına sabitle
        fixedX = workspace.CurrentCamera.ViewportSize.X / 2
        fixedY = workspace.CurrentCamera.ViewportSize.Y / 2
        updateModeLabel()
    else
        fixedClickButton.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
        fixedClickButton.Text = "SABİT KONUM"
        updateModeLabel()
    end
end)

turboButton.MouseButton1Click:Connect(function()
    turboMode = not turboMode
    if turboMode then
        turboButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        turboButton.Text = "TURBO 🔥"
        updateModeLabel()
    else
        turboButton.BackgroundColor3 = Color3.fromRGB(180, 100, 60)
        turboButton.Text = "TURBO MOD"
        updateModeLabel()
    end
    
    if isEnabled then
        stopAutoClicker()
        startOptimizedClicker()
    end
end)

function updateModeLabel()
    local modeText = "Mod: " .. (turboMode and "TURBO" or "Normal")
    local positionText = "Konum: " .. (useFixedPosition and "Sabit" or "Hareketli")
    modeLabel.Text = modeText .. " | " .. positionText
end

toggleButton.MouseButton1Click:Connect(toggleAutoClicker)
minimizeButton.MouseButton1Click:Connect(toggleMinimize)

closeButton.MouseButton1Click:Connect(function()
    isGuiVisible = false
    mainFrame.Visible = false
    if isEnabled then
        isEnabled = false
        stopAutoClicker()
    end
end)

-- Klavye Kısayolları
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.B then
        if isGuiVisible then
            toggleAutoClicker()
        end
    elseif input.KeyCode == Enum.KeyCode.X then
        isGuiVisible = false
        mainFrame.Visible = false
        if isEnabled then
            isEnabled = false
            stopAutoClicker()
        end
    end
end)

-- Oyun çıkışında temizlik
game:GetService("UserInputService").WindowFocusReleased:Connect(function()
    if isEnabled then
        isEnabled = false
        stopAutoClicker()
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        toggleButton.Text = "BAŞLAT (B)"
        statusLabel.Text = "🔴 DURUYOR"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        realCpsLabel.Text = "ANLIK CPS: 0"
    end
end)

-- Sabit konumu ayarla (ekranın ortası)
fixedX = workspace.CurrentCamera.ViewportSize.X / 2
fixedY = workspace.CurrentCamera.ViewportSize.Y / 2

print("⚡ ULTRA CLICKER Yüklendi!")
print("B Tuşu: Başlat/Durdur")
print("X Tuşu: GUI'yi Kapat + Scripti Durdur")
print("- Butonu: Menüyü Küçült/Büyüt")
print("SABİT KONUM: Mouse kaymasını engeller")
print("TURBO MOD: Yüksek CPS için")
print("Max CPS: 2000")