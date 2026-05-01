-- Limpa GUIs antigas do LK7 para não bugar
for _, oldGui in pairs(game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
    if oldGui.Name == "LK7_KurdStyle_V6" or oldGui.Name == "LK7_Main" then
        oldGui:Destroy()
    end
end

local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui")
sg.Name = "LK7_KurdStyle_V6"
sg.Parent = player:WaitForChild("PlayerGui")
sg.ResetOnSpawn = false

-- Cores do Vídeo
local COR_ROXO = Color3.fromRGB(15, 10, 25)
local COR_BORDA = Color3.fromRGB(130, 40, 255)
local COR_BOTAO = Color3.fromRGB(40, 20, 70)

-- Função para criar os painéis idênticos ao vídeo
local function CriarPainel(nome, tamanho, posicao)
    local Frame = Instance.new("Frame", sg)
    Frame.Size = tamanho
    Frame.Position = posicao
    Frame.BackgroundColor3 = COR_ROXO
    Frame.BorderSizePixel = 2
    Frame.BorderColor3 = COR_BORDA
    Frame.Active = true
    Frame.Draggable = true
    
    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(1, 0, 0, 25)
    Title.BackgroundColor3 = COR_BORDA
    Title.Text = nome
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 12
    
    local List = Instance.new("UIListLayout", Frame)
    List.Padding = UDim.new(0, 5)
    List.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    -- Espaçador para o título não cobrir botões
    local Spacer = Instance.new("Frame", Frame)
    Spacer.Size = UDim2.new(1, 0, 0, 30)
    Spacer.BackgroundTransparency = 1
    
    return Frame
end

-- Criando as 3 Janelas do Vídeo
local ToolPanel = CriarPainel("Tsk Fake Tools", UDim2.new(0, 180, 0, 220), UDim2.new(0.05, 0, 0.3, 0))
local ChatPanel = CriarPainel("Chat Panel", UDim2.new(0, 180, 0, 150), UDim2.new(0.4, 0, 0.7, 0))
local RobuxPanel = CriarPainel("Tsk Fake Robux", UDim2.new(0, 200, 0, 320), UDim2.new(0.75, 0, 0.25, 0))

-- Função de Botão
local function AddBtn(nome, parent, func)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.9, 0, 0, 30)
    b.BackgroundColor3 = COR_BOTAO
    b.Text = nome
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    b.MouseButton1Click:Connect(func)
end

-- FUNCIONALIDADES IGUAIS AO VÍDEO
AddBtn("Ragdoll", RobuxPanel, function() 
    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics) 
    task.wait(2) 
    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end)

AddBtn("Rocket", RobuxPanel, function()
    local hrp = player.Character.HumanoidRootPart
    local bv = Instance.new("BodyVelocity", hrp)
    bv.Velocity = Vector3.new(0, 150, 0)
    bv.MaxForce = Vector3.new(0, math.huge, 0)
    task.wait(2.5) bv:Destroy()
end)

-- FLASH TP (Com a lógica do item Brainrot)
AddBtn("Flash TP [P]", RobuxPanel, function()
    local char = player.Character
    if char:FindFirstChild("Brainrot") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -80)
    else
        print("Pegue o Brainrot na mão!")
    end
end)

-- FUNÇÃO DE TRANSPARÊNCIA (O que você pediu no começo)
AddBtn("Bases Transparente", ToolPanel, function()
    local bases = workspace:FindFirstChild("Bases") or workspace:FindFirstChild("Map")
    if bases then
        for _, p in pairs(bases:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency = (p.Transparency == 0 and 0.6 or 0) end
        end
    end
end)

-- Botões de Chat
AddBtn("Chat: Obrigado", ChatPanel, function() game:GetService("Chat"):Chat(player.Character.Head, "Obrigado", "White") end)
AddBtn("Chat: Tmj", ChatPanel, function() game:GetService("Chat"):Chat(player.Character.Head, "Tmj", "White") end)

-- Valor de Robux Fake (Igual ao vídeo)
local rb = Instance.new("TextLabel", RobuxPanel)
rb.Size = UDim2.new(1, 0, 0, 30)
rb.Text = "Robux: 11.284"
rb.TextColor3 = Color3.new(1, 1, 0)
rb.BackgroundTransparency = 1
rb.Font = Enum.Font.GothamBold

-- Tecla P para Toggle
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then sg.Enabled = not sg.Enabled end
end)

print("LK7 Carregado com Sucesso!")
