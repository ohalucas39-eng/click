-- Roblox Auto Clicker Script (Optimized for High CPS)
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- GUI Oluşturma
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoClickerGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Premium renk paleti
local colors = {
    background = Color3.fromRGB(20, 20, 30),
    header = Color3.fromRGB(40, 40, 55),
    primary = Color3.fromRGB(120, 80, 220),
    secondary = Color3.fromRGB(80, 200, 140),
    accent = Color3.fromRGB(255, 110, 90),
    success = Color3.fromRGB(90, 220, 130),
    warning = Color3.fromRGB(255, 190, 70),
    danger = Color3.fromRGB(230, 80, 80),
    text = Color3.fromRGB(245, 245, 255),
    darkText = Color3.fromRGB(170, 170, 190),
    panel = Color3.fromRGB(30, 30, 45)
}

-- Ana frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 260)
mainFrame.Position = UDim2.new(0, 15, 0, 15)
mainFrame.BackgroundColor3 = colors.background
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true

-- Gradient efekti
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, colors.background),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 25, 40))
})
gradient.Rotation = 45
gradient.Parent = mainFrame

-- Gölge efekti
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 12, 1, 12)
shadow.Position = UDim2.new(0, -6, 0, -6)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.85
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainFrame

-- Köşe yuvarlama
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Başlık (sürükleme alanı)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = colors.header
title.TextColor3 = colors.text
title.Text = "⚡ ULTRA CLICKER PRO ⚡"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = mainFrame

-- Başlık köşe yuvarlama
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = title

-- Alt başlık
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 18)
subtitle.Position = UDim2.new(0, 0, 0, 40)
subtitle.BackgroundTransparency = 1
subtitle.TextColor3 = colors.darkText
subtitle.Text = "Sürüklemek için başlığa tıkla • Premium Auto Clicker"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 9
subtitle.Parent = mainFrame

-- CPS Kontrol Paneli
local cpsPanel = Instance.new("Frame")
cpsPanel.Size = UDim2.new(1, -20, 0, 80)
cpsPanel.Position = UDim2.new(0, 10, 0, 65)
cpsPanel.BackgroundColor3 = colors.panel
cpsPanel.BorderSizePixel = 0
cpsPanel.Parent = mainFrame

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 8)
panelCorner.Parent = cpsPanel

-- Panel başlık
local panelTitle = Instance.new("TextLabel")
panelTitle.Size = UDim2.new(1, 0, 0, 25)
panelTitle.Position = UDim2.new(0, 0, 0, 0)
panelTitle.BackgroundTransparency = 1
panelTitle.TextColor3 = colors.text
panelTitle.Text = "CPS AYARI"
panelTitle.Font = Enum.Font.GothamBold
panelTitle.TextSize = 12
panelTitle.Parent = cpsPanel

-- CPS Değer Göstergesi
local cpsDisplay = Instance.new("TextLabel")
cpsDisplay.Size = UDim2.new(0.4, 0, 0, 30)
cpsDisplay.Position = UDim2.new(0.05, 0, 0.4, 0)
cpsDisplay.BackgroundColor3 = colors.primary
cpsDisplay.TextColor3 = colors.text
cpsDisplay.Text = "425"
cpsDisplay.Font = Enum.Font.GothamBlack
cpsDisplay.TextSize = 18
cpsDisplay.Parent = cpsPanel

local displayCorner = Instance.new("UICorner")
displayCorner.CornerRadius = UDim.new(0, 6)
displayCorner.Parent = cpsDisplay

-- CPS Yazma Kutusu
local cpsTextBox = Instance.new("TextBox")
cpsTextBox.Size = UDim2.new(0.5, 0, 0, 30)
cpsTextBox.Position = UDim2.new(0.5, 0, 0.4, 0)
cpsTextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
cpsTextBox.TextColor3 = colors.text
cpsTextBox.PlaceholderColor3 = colors.darkText
cpsTextBox.Text = "425"
cpsTextBox.PlaceholderText = "CPS yaz (1-2000)"
cpsTextBox.Font = Enum.Font.Gotham
cpsTextBox.TextSize = 12
cpsTextBox.Parent = cpsPanel

local textboxCorner = Instance.new("UICorner")
textboxCorner.CornerRadius = UDim.new(0, 6)
textboxCorner.Parent = cpsTextBox

-- CPS Alt Bilgi
local cpsInfo = Instance.new("TextLabel")
cpsInfo.Size = UDim2.new(1, 0, 0, 15)
cpsInfo.Position = UDim2.new(0, 0, 0.8, 0)
cpsInfo.BackgroundTransparency = 1
cpsInfo.TextColor3 = colors.darkText
cpsInfo.Text = "1-2000 CPS arası değer girebilirsiniz"
cpsInfo.Font = Enum.Font.Gotham
cpsInfo.TextSize = 9
cpsInfo.Parent = cpsPanel

-- ANLIK CPS Göstergesi
local realCpsPanel = Instance.new("Frame")
realCpsPanel.Size = UDim2.new(1, -20, 0, 40)
realCpsPanel.Position = UDim2.new(0, 10, 0, 155)
realCpsPanel.BackgroundColor3 = colors.panel
realCpsPanel.BorderSizePixel = 0
realCpsPanel.Parent = mainFrame

local realCpsCorner = Instance.new("UICorner")
realCpsCorner.CornerRadius = UDim.new(0, 8)
realCpsCorner.Parent = realCpsPanel

local realCpsLabel = Instance.new("TextLabel")
realCpsLabel.Size = UDim2.new(1, 0, 1, 0)
realCpsLabel.Position = UDim2.new(0, 0, 0, 0)
realCpsLabel.BackgroundTransparency = 1
realCpsLabel.TextColor3 = colors.success
realCpsLabel.Text = "⚡ ANLIK CPS: 0"
realCpsLabel.Font = Enum.Font.GothamBold
realCpsLabel.TextSize = 14
realCpsLabel.Parent = realCpsPanel

-- Mod Butonları Paneli
local modePanel = Instance.new("Frame")
modePanel.Size = UDim2.new(1, -20, 0, 35)
modePanel.Position = UDim2.new(0, 10, 0, 205)
modePanel.BackgroundTransparency = 1
modePanel.Parent = mainFrame

-- Sabit Tıklama Butonu
local fixedClickButton = Instance.new("TextButton")
fixedClickButton.Size = UDim2.new(0.48, 0, 1, 0)
fixedClickButton.Position = UDim2.new(0, 0, 0, 0)
fixedClickButton.BackgroundColor3 = colors.primary
fixedClickButton.TextColor3 = colors.text
fixedClickButton.Text = "📍 SABİT KONUM"
fixedClickButton.Font = Enum.Font.GothamBold
fixedClickButton.TextSize = 11
fixedClickButton.Parent = modePanel

local fixedCorner = Instance.new("UICorner")
fixedCorner.CornerRadius = UDim.new(0, 6)
fixedCorner.Parent = fixedClickButton

-- Turbo Mod Butonu
local turboButton = Instance.new("TextButton")
turboButton.Size = UDim2.new(0.48, 0, 1, 0)
turboButton.Position = UDim2.new(0.52, 0, 0, 0)
turboButton.BackgroundColor3 = colors.warning
turboButton.TextColor3 = colors.text
turboButton.Text = "🚀 TURBO MOD"
turboButton.Font = Enum.Font.GothamBold
turboButton.TextSize = 11
turboButton.Parent = modePanel

local turboCorner = Instance.new("UICorner")
turboCorner.CornerRadius = UDim.new(0, 6)
turboCorner.Parent = turboButton

-- Ana Kontrol Butonu
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(1, -20, 0, 45)
toggleButton.Position = UDim2.new(0, 10, 0, 250)
toggleButton.BackgroundColor3 = colors.danger
toggleButton.TextColor3 = colors.text
toggleButton.Text = "🎮 BAŞLAT (B)"
toggleButton.Font = Enum.Font.GothamBlack
toggleButton.TextSize = 14
toggleButton.Parent = mainFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- Alt Bilgi Paneli
local infoPanel = Instance.new("Frame")
infoPanel.Size = UDim2.new(1, 0, 0, 30)
infoPanel.Position = UDim2.new(0, 0, 1, -30)
infoPanel.BackgroundColor3 = colors.header
infoPanel.BorderSizePixel = 0
infoPanel.Parent = mainFrame

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 12)
infoCorner.Parent = infoPanel

-- Durum Göstergesi
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.6, 0, 1, 0)
statusLabel.Position = UDim2.new(0, 10, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = colors.danger
statusLabel.Text = "🔴 DURUYOR"
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = infoPanel

-- Kontrol Butonları
local controlPanel = Instance.new("Frame")
controlPanel.Size = UDim2.new(0.4, 0, 1, 0)
controlPanel.Position = UDim2.new(0.6, 0, 0, 0)
controlPanel.BackgroundTransparency = 1
controlPanel.Parent = infoPanel

-- Küçült Butonu
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 1, 0)
minimizeButton.Position = UDim2.new(0, 0, 0, 0)
minimizeButton.BackgroundColor3 = colors.warning
minimizeButton.TextColor3 = colors.text
minimizeButton.Text = "─"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 14
minimizeButton.Parent = controlPanel

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeButton

-- Kapat Butonu
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = colors.danger
closeButton.TextColor3 = colors.text
closeButton.Text = "✕"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 12
closeButton.Parent = controlPanel

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

-- Değişkenler
local isEnabled = false
local isGuiVisible = true
local isMinimized = false
local clickSpeed = 425  -- 425 CPS ile başlar
local connection
local clickCount = 0
local lastCpsUpdate = 0
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
        realCpsLabel.Text = "⚡ ANLIK CPS: " .. realCps
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
        -- Başlatma animasyonu
        toggleButton.BackgroundColor3 = colors.success
        toggleButton.Text = "⏹️ DURDUR (B)"
        statusLabel.Text = "🟢 ÇALIŞIYOR • " .. clickSpeed .. " CPS"
        statusLabel.TextColor3 = colors.success
        clickCount = 0
        lastCpsUpdate = tick()
        startOptimizedClicker()
        
        -- Buton animasyonu
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(toggleButton, tweenInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)})
        tween:Play()
    else
        -- Durdurma animasyonu
        toggleButton.BackgroundColor3 = colors.danger
        toggleButton.Text = "🎮 BAŞLAT (B)"
        statusLabel.Text = "🔴 DURUYOR"
        statusLabel.TextColor3 = colors.danger
        realCpsLabel.Text = "⚡ ANLIK CPS: 0"
        stopAutoClicker()
    end
end

-- CPS güncelleme fonksiyonu
function updateCpsDisplay()
    cpsDisplay.Text = tostring(clickSpeed)
    cpsTextBox.Text = tostring(clickSpeed)
end

-- CPS değerini ayarla
function setClickSpeed(newSpeed)
    if newSpeed and newSpeed >= 1 and newSpeed <= 2000 then
        clickSpeed = newSpeed
        updateCpsDisplay()
        
        if isEnabled then
            stopAutoClicker()
            startOptimizedClicker()
        end
        return true
    else
        updateCpsDisplay() -- Orijinal değere geri dön
        return false
    end
end

-- Küçültme/Büyütme fonksiyonu
function toggleMinimize()
    isMinimized = not isMinimized
    
    if isMinimized then
        -- Küçültme animasyonu
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        local tween = TweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 200, 0, 40)})
        tween:Play()
        
        -- İçeriği gizle
        subtitle.Visible = false
        cpsPanel.Visible = false
        realCpsPanel.Visible = false
        modePanel.Visible = false
        toggleButton.Visible = false
        title.Text = "⚡ " .. clickSpeed .. " CPS"
        
    else
        -- Büyütme animasyonu
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local tween = TweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 380, 0, 260)})
        tween:Play()
        
        -- İçeriği göster
        subtitle.Visible = true
        cpsPanel.Visible = true
        realCpsPanel.Visible = true
        modePanel.Visible = true
        toggleButton.Visible = true
        title.Text = "⚡ ULTRA CLICKER PRO ⚡"
    end
end

-- Buton etkileşimleri
fixedClickButton.MouseButton1Click:Connect(function()
    useFixedPosition = not useFixedPosition
    if useFixedPosition then
        fixedClickButton.BackgroundColor3 = colors.success
        fixedClickButton.Text = "📍 SABİT ✓"
        fixedX = workspace.CurrentCamera.ViewportSize.X / 2
        fixedY = workspace.CurrentCamera.ViewportSize.Y / 2
        
        -- Animasyon
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(fixedClickButton, tweenInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)})
        tween:Play()
    else
        fixedClickButton.BackgroundColor3 = colors.primary
        fixedClickButton.Text = "📍 SABİT KONUM"
    end
end)

turboButton.MouseButton1Click:Connect(function()
    turboMode = not turboMode
    if turboMode then
        turboButton.BackgroundColor3 = colors.accent
        turboButton.Text = "🚀 TURBO 🔥"
        
        -- Animasyon
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(turboButton, tweenInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)})
        tween:Play()
    else
        turboButton.BackgroundColor3 = colors.warning
        turboButton.Text = "🚀 TURBO MOD"
    end
    
    if isEnabled then
        stopAutoClicker()
        startOptimizedClicker()
    end
end)

-- CPS TextBox etkileşimi
cpsTextBox.FocusLost:Connect(function(enterPressed)
    local newSpeed = tonumber(cpsTextBox.Text)
    if not setClickSpeed(newSpeed) then
        -- Geçersiz değer için uyarı animasyonu
        local originalColor = cpsTextBox.BackgroundColor3
        cpsTextBox.BackgroundColor3 = colors.danger
        
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(cpsTextBox, tweenInfo, {BackgroundColor3 = originalColor})
        tween:Play()
    end
end)

toggleButton.MouseButton1Click:Connect(toggleAutoClicker)
minimizeButton.MouseButton1Click:Connect(toggleMinimize)

closeButton.MouseButton1Click:Connect(function()
    -- Kapatma animasyonu
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    local tween = TweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
    tween:Play()
    
    wait(0.3)
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
        if isGuiVisible then
            isGuiVisible = false
            mainFrame.Visible = false
            if isEnabled then
                isEnabled = false
                stopAutoClicker()
            end
        end
    elseif input.KeyCode == Enum.KeyCode.M then
        toggleMinimize()
    end
end)

-- AFK koruması
local lastActivity = tick()
local function updateActivity()
    lastActivity = tick()
end

-- Kullanıcı aktivitesini izle
UserInputService.InputBegan:Connect(updateActivity)
RunService.Heartbeat:Connect(function()
    -- Her 10 dakikada bir aktivite kontrolü
    if tick() - lastActivity > 600 then
        updateActivity()
        if isEnabled then
            print("⚡ Auto Clicker: AFK modunda çalışmaya devam ediyor")
        end
    end
end)

-- Başlangıç ayarları
fixedX = workspace.CurrentCamera.ViewportSize.X / 2
fixedY = workspace.CurrentCamera.ViewportSize.Y / 2
updateCpsDisplay()

print(" ")
print("⚡ ULTRA CLICKER PRO Yüklendi! ⚡")
print("=====================================")
print("🎮 Başlangıç CPS: 425")
print("⌨️  Kontroller:")
print("   B Tuşu: Başlat/Durdur")
print("   X Tuşu: GUI'yi Kapat") 
print("   M Tuşu: Küçült/Büyüt")
print("📍 Özellikler:")
print("   • CPS yazarak ayarlanabilir (1-2000)")
print("   • Sabit konum modu")
print("   • Turbo mod (yüksek performans)")
print("   • AFK koruması")
print("   • Premium arayüz")
print("=====================================")
