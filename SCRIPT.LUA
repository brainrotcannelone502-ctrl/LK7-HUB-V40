local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "LK7_Brainrot_V2"
sg.ResetOnSpawn = false

local TECLA_TOGGLE = Enum.KeyCode.P

-- DESIGN PRINCIPAL (ESTILO ROXO DO VÍDEO)
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 500, 0, 350)
Main.Position = UDim2.new(0.5, -250, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(25, 10, 50) -- Roxo Escuro
Main.Active = true
Main.Draggable = true
local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 12)

-- BARRA LATERAL (TABS)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 130, 1, -20)
Sidebar.Position = UDim2.new(0, 10, 0, 10)
Sidebar.BackgroundColor3 = Color3.fromRGB(35, 15, 70)
Instance.new("UICorner", Sidebar)

local TabList = Instance.new("UIListLayout", Sidebar)
TabList.Padding = UDim.new(0, 8)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ÁREA DE CONTEÚDO (BOTÕES)
local Container = Instance.new("ScrollingFrame", Main)
Container.Size = UDim2.new(1, -160, 1, -60)
Container.Position = UDim2.new(0, 150, 0, 50)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Container.ScrollBarThickness = 2

local Grid = Instance.new("UIGridLayout", Container)
Grid.CellSize = UDim2.new(0, 160, 0, 35)
Grid.CellPadding = UDim2.new(0, 10, 0, 10)

-- FUNÇÕES DE AJUDA
local function CreateAction(name, callback)
    local btn = Instance.new("TextButton", Container)
    btn.Size = UDim2.new(0, 160, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(50, 20, 100)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

-- --- NOVAS FUNÇÕES DO VÍDEO ---

-- 1. FAKE PURCHASE (SIMULAR COMPRA)
CreateAction("Fake Buy Admin", function()
    -- Simula a janelinha de compra do Roblox
    local fakeGui = Instance.new("Frame", sg)
    fakeGui.Size = UDim2.new(0, 300, 0, 150)
    fakeGui.Position = UDim2.new(0.5, -150, 0.5, -75)
    fakeGui.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", fakeGui)
    
    local txt = Instance.new("TextLabel", fakeGui)
    txt.Size = UDim2.new(1, 0, 0.6, 0)
    txt.Text = "Você deseja comprar 'Admin Commands'?"
    txt.TextColor3 = Color3.new(1,1,1)
    txt.BackgroundTransparency = 1

    local buy = Instance.new("TextButton", fakeGui)
    buy.Size = UDim2.new(0, 100, 0, 30)
    buy.Position = UDim2.new(0.5, -50, 0.7, 0)
    buy.Text = "Comprar"
    buy.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    
    buy.MouseButton1Click:Connect(function()
        fakeGui:Destroy()
        -- Mensagem de sucesso fake
        print("Compra realizada com sucesso!")
    end)
end)

-- 2. FLASH TP (COMO PEDIDO ANTERIORMENTE)
CreateAction("Flash TP (P)", function()
    local char = player.Character
    if char and char:FindFirstChild("Brainrot") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -50)
    end
end)

-- 3. NIGHT VISION
local nvOn = false
CreateAction("Night Vision", function()
    nvOn = not nvOn
    game.Lighting.Brightness = nvOn and 3 or 1
    game.Lighting.OutdoorAmbient = nvOn and Color3.new(1,1,1) or Color3.fromRGB(127, 127, 127)
end)

-- 4. INVERSE (VIRAR TELA)
CreateAction("Inverse View", function()
    local cam = workspace.CurrentCamera
    cam.CFrame = cam.CFrame * CFrame.Angles(0, 0, math.rad(180))
end)

-- SISTEMA DE TOGGLE
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == TECLA_TOGGLE then 
        Main.Visible = not Main.Visible 
    end
end)

print("LK7 HUB - Brainrot Edition Carregado!")
