local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "LK7_V6_Official"
sg.ResetOnSpawn = false

-- Configurações de Estilo Vídeo
local COR_ROXO = Color3.fromRGB(30, 10, 60)
local COR_BORDA = Color3.fromRGB(130, 40, 255)
local COR_BOTAO = Color3.fromRGB(50, 20, 100)

local function CriarPainel(nome, tamanho, posicao)
    local Frame = Instance.new("Frame", sg)
    Frame.Size = tamanho
    Frame.Position = posicao
    Frame.BackgroundColor3 = COR_ROXO
    Frame.BorderColor3 = COR_BORDA
    Frame.BorderSizePixel = 2
    Frame.Active = true
    Frame.Draggable = true
    
    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(1, 0, 0, 25)
    Title.BackgroundColor3 = COR_BORDA
    Title.Text = nome
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 12
    
    return Frame
end

-- 1. PAINEL ESQUERDO (Tsk Fake Tools)
local ToolPanel = CriarPainel("Tsk Fake Tools", UDim2.new(0, 180, 0, 250), UDim2.new(0, 50, 0.4, 0))
local Input = Instance.new("TextBox", ToolPanel)
Input.Size = UDim2.new(0.9, 0, 0, 30)
Input.Position = UDim2.new(0.05, 0, 0.15, 0)
Input.PlaceholderText = "select player"
Input.BackgroundColor3 = COR_BOTAO
Input.TextColor3 = Color3.new(1,1,1)

-- 2. PAINEL CENTRAL (Chat Panel)
local ChatPanel = CriarPainel("Chat Panel", UDim2.new(0, 180, 0, 150), UDim2.new(0.4, 0, 0.7, 0))

-- 3. PAINEL DIREITO (Tsk Fake Robux - O Principal)
local RobuxPanel = CriarPainel("Tsk Fake Robux", UDim2.new(0, 200, 0, 350), UDim2.new(0.8, 0, 0.3, 0))
local List = Instance.new("UIListLayout", RobuxPanel)
List.Padding = UDim.new(0, 5)
List.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Espaçador para o título
Instance.new("Frame", RobuxPanel).Size = UDim2.new(0,0,0,30).BackgroundTransparency = 1

-- FUNÇÕES DOS BOTÕES (Igual ao vídeo)
local function Botao(nome, parent, acao)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0.9, 0, 0, 30)
    b.BackgroundColor3 = COR_BOTAO
    b.Text = nome
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(acao)
end

-- Funcionalidades
Botao("Ragdoll", RobuxPanel, function() 
    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics) 
    task.wait(2) 
    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end)

Botao("Rocket", RobuxPanel, function()
    local bv = Instance.new("BodyVelocity", player.Character.HumanoidRootPart)
    bv.Velocity = Vector3.new(0, 150, 0)
    bv.MaxForce = Vector3.new(0, math.huge, 0)
    task.wait(2) bv:Destroy()
end)

Botao("Balloon", RobuxPanel, function()
    local b = Instance.new("Part", workspace)
    b.Shape = "Ball"
    b.Size = Vector3.new(4,4,4)
    b.Position = player.Character.Head.Position + Vector3.new(0,8,0)
    local rope = Instance.new("RopeConstraint", player.Character)
    local a0, a1 = Instance.new("Attachment", b), Instance.new("Attachment", player.Character.Head)
    rope.Attachment0, rope.Attachment1 = a0, a1
    rope.Length = 6
end)

Botao("Flash TP [P]", RobuxPanel, function()
    if player.Character:FindFirstChild("Brainrot") then
        player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -70)
    end
end)

Botao("Night Vision", RobuxPanel, function()
    game.Lighting.Brightness = 3
    game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
end)

-- Botões de Chat
Botao("Chat: Obrigado", ChatPanel, function() game:GetService("Chat"):Chat(player.Character.Head, "Obrigado", "White") end)
Botao("Chat: Tmj", ChatPanel, function() game:GetService("Chat"):Chat(player.Character.Head, "Tmj", "White") end)

-- Robux Fake embaixo
local RobuxValue = Instance.new("TextLabel", RobuxPanel)
RobuxValue.Size = UDim2.new(1, 0, 0, 30)
RobuxValue.Text = "Robux: 11.284"
RobuxValue.TextColor3 = Color3.new(1, 1, 0)
RobuxValue.BackgroundTransparency = 1
RobuxValue.Font = Enum.Font.GothamBold

-- Tecla P para fechar tudo
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then sg.Enabled = not sg.Enabled end
end)
