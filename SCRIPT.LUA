local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "LK7_KurdStyle_V6"
sg.ResetOnSpawn = false

-- Configurações de Cores e Estilo (Baseado no vídeo)
local CorFundo = Color3.fromRGB(15, 10, 30)
local CorBorda = Color3.fromRGB(120, 50, 255)
local CorBotao = Color3.fromRGB(45, 20, 80)

local function CriarJanela(nome, tamanho, posicao)
    local Frame = Instance.new("Frame", sg)
    Frame.Name = nome
    Frame.Size = tamanho
    Frame.Position = posicao
    Frame.BackgroundColor3 = CorFundo
    Frame.BorderSizePixel = 2
    Frame.BorderColor3 = CorBorda
    Frame.Active = true
    Frame.Draggable = true
    
    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Text = nome
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundColor3 = CorBorda
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    
    return Frame
end

-- 1. PAINEL ESQUERDO: Tsk Fake Tools
local PainelTools = CriarJanela("Tsk Fake Tools", UDim2.new(0, 200, 0, 280), UDim2.new(0, 50, 0.5, -140))
local InputPlayer = Instance.new("TextBox", PainelTools)
InputPlayer.Size = UDim2.new(0.8, 0, 0, 30)
InputPlayer.Position = UDim2.new(0.1, 0, 0.15, 0)
InputPlayer.PlaceholderText = "select player"
InputPlayer.BackgroundColor3 = CorBotao
InputPlayer.TextColor3 = Color3.new(1,1,1)

-- 2. PAINEL DIREITO: Tsk Fake Robux (Painel Principal do vídeo)
local PainelRobux = CriarJanela("Tsk Fake Robux", UDim2.new(0, 220, 0, 320), UDim2.new(1, -270, 0.5, -160))
local ListLayout = Instance.new("UIListLayout", PainelRobux)
ListLayout.Padding = UDim.new(0, 5)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("Frame", PainelRobux).Size = UDim2.new(0,0,0,35) -- Espaçador

local function AddButton(nome, parent, func)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.BackgroundColor3 = CorBotao
    btn.Text = nome
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 12
    btn.MouseButton1Click:Connect(func)
    return btn
end

-- Funcionalidades do Vídeo
AddButton("Ragdoll", PainelRobux, function()
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Physics) task.wait(2) hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
end)

AddButton("Rocket", PainelRobux, function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.Velocity = Vector3.new(0, 150, 0)
        task.wait(2) bv:Destroy()
    end
end)

AddButton("Balloon", PainelRobux, function()
    -- Lógica do Balão que você já usava no Dragon Luck Block
    local b = Instance.new("Part", player.Character)
    b.Shape = Enum.PartType.Ball
    b.Size = Vector3.new(3,3,3)
    b.Position = player.Character.Head.Position + Vector3.new(0,5,0)
    local rope = Instance.new("RopeConstraint", player.Character)
    local a0 = Instance.new("Attachment", b)
    local a1 = Instance.new("Attachment", player.Character.Head)
    rope.Attachment0 = a0 rope.Attachment1 = a1 rope.Length = 5
end)

-- 3. PAINEL DE CHAT (Lógica para mensagens visuais)
local PainelChat = CriarJanela("Chat Panel", UDim2.new(0, 180, 0, 150), UDim2.new(0.5, -90, 0.8, -75))
AddButton("Chat: Obrigado", PainelChat, function() 
    game:GetService("Chat"):Chat(player.Character.Head, "Obrigado", "White") 
end)

-- Botão Flash TP (P)
AddButton("Flash TP [P]", PainelRobux, function()
    local char = player.Character
    if char and char:FindFirstChild("Brainrot") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -60)
    end
end)

-- Exibição de Robux Fake (Igual ao vídeo)
local RobuxTxt = Instance.new("TextLabel", PainelRobux)
RobuxTxt.Size = UDim2.new(1, 0, 0, 30)
RobuxTxt.Text = "Robux: 11.284"
RobuxTxt.TextColor3 = Color3.fromRGB(255, 255, 0)
RobuxTxt.BackgroundTransparency = 1

-- Atalho para ocultar tudo (Tecla P)
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then
        sg.Enabled = not sg.Enabled
    end
end)
