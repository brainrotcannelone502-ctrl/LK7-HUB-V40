-- Limpeza agressiva de execuções travadas
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

for _, old in pairs(pgui:GetChildren()) do
    if old.Name == "LK7_V6" then old:Destroy() end
end

-- Criando a ScreenGui com prioridade
local sg = Instance.new("ScreenGui")
sg.Name = "LK7_V6"
sg.Parent = pgui
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true -- Garante que apareça independente da resolução

-- Cores do vídeo (image_c5e0fc.png)
local COR_ROXO = Color3.fromRGB(15, 10, 25)
local COR_BORDA = Color3.fromRGB(130, 40, 255)
local COR_BOTAO = Color3.fromRGB(40, 20, 70)

-- Função de construção de painéis (Design lv_0_20260420103717.mp4)
local function Painel(nome, size, pos)
    local f = Instance.new("Frame", sg)
    f.Size = size
    f.Position = pos
    f.BackgroundColor3 = COR_ROXO
    f.BorderSizePixel = 2
    f.BorderColor3 = COR_BORDA
    f.Active = true
    f.Draggable = true
    
    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1, 0, 0, 25)
    t.BackgroundColor3 = COR_BORDA
    t.Text = nome
    t.TextColor3 = Color3.new(1, 1, 1)
    t.Font = Enum.Font.GothamBold
    t.TextSize = 12
    
    local l = Instance.new("UIListLayout", f)
    l.Padding = UDim.new(0, 5)
    l.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    Instance.new("Frame", f).Size = UDim2.new(1, 0, 0, 25).BackgroundTransparency = 1
    return f
end

-- Gerando as 3 janelas do vídeo
local Tools = Painel("Tsk Fake Tools", UDim2.new(0, 180, 0, 200), UDim2.new(0.05, 0, 0.3, 0))
local Chat = Painel("Chat Panel", UDim2.new(0, 180, 0, 150), UDim2.new(0.4, 0, 0.7, 0))
local Robux = Painel("Tsk Fake Robux", UDim2.new(0, 200, 0, 320), UDim2.new(0.75, 0, 0.25, 0))

local function Botao(n, p, c)
    local b = Instance.new("TextButton", p)
    b.Size = UDim2.new(0.9, 0, 0, 30)
    b.BackgroundColor3 = COR_BOTAO
    b.Text = n
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    b.MouseButton1Click:Connect(c)
end

-- Funcionalidades (Flash TP e Brainrot)
Botao("Ragdoll", Robux, function() 
    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    task.wait(2)
    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end)

Botao("Flash TP [P]", Robux, function()
    if player.Character:FindFirstChild("Brainrot") then
        player.Character.HumanoidRootPart.CFrame *= CFrame.new(0, 0, -80)
    end
end)

Botao("Bases Transparentes", Tools, function()
    local b = workspace:FindFirstChild("Bases") or workspace:FindFirstChild("Map")
    if b then
        for _, v in pairs(b:GetDescendants()) do
            if v:IsA("BasePart") then v.Transparency = (v.Transparency == 0 and 0.6 or 0) end
        end
    end
end)

local rb = Instance.new("TextLabel", Robux)
rb.Size = UDim2.new(1, 0, 0, 30)
rb.Text = "Robux: 11.284"
rb.TextColor3 = Color3.new(1, 1, 0)
rb.BackgroundTransparency = 1
rb.Font = Enum.Font.GothamBold

-- Toggle com tecla P
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then sg.Enabled = not sg.Enabled end
end)

warn("LK7 HUB INJETADO!")
