local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "LK7_V40_Final"
sg.ResetOnSpawn = false

local COR_ROXO = Color3.fromRGB(15, 10, 25)
local COR_BORDA = Color3.fromRGB(130, 40, 255)
local COR_BOTAO = Color3.fromRGB(45, 20, 80)

-- Função para criar janelas flutuantes (como no vídeo)
local function CriarJanela(nome, tamanho, posicao)
    local Frame = Instance.new("Frame", sg)
    Frame.Name = nome
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
    
    Instance.new("Frame", Frame).Size = UDim2.new(1, 0, 0, 30).BackgroundTransparency = 1
    return Frame
end

local function AddBtn(n, p, c)
    local b = Instance.new("TextButton", p)
    b.Size = UDim2.new(0.9, 0, 0, 30)
    b.BackgroundColor3 = COR_BOTAO
    b.Text = n
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    b.MouseButton1Click:Connect(c)
end

-- 1. PAINEL PRINCIPAL (Tsk Fake Robux)
local RobuxPanel = CriarJanela("Tsk Fake Robux", UDim2.new(0, 200, 0, 250), UDim2.new(0.75, 0, 0.2, 0))

-- 2. PAINEL FAKE GLOBAL GIFT (O que você pediu)
local GiftPanel = CriarJanela("Fake Global Gift", UDim2.new(0, 220, 0, 220), UDim2.new(0.05, 0, 0.2, 0))

local GiftInput = Instance.new("TextBox", GiftPanel)
GiftInput.Size = UDim2.new(0.9, 0, 0, 30)
GiftInput.PlaceholderText = "Nome do Jogador..."
GiftInput.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
GiftInput.TextColor3 = Color3.new(1,1,1)
GiftInput.Font = Enum.Font.GothamBold
GiftInput.TextSize = 11
Instance.new("UICorner", GiftInput)

local function SimularPresente(item)
    local alvo = GiftInput.Text ~= "" and GiftInput.Text or "Jogador"
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "[GLOBAL GIFT]: " .. player.DisplayName .. " enviou " .. item .. " para " .. alvo .. "!";
        Color = Color3.fromRGB(255, 255, 0);
        Font = Enum.Font.GothamBold;
    })
end

-- Botões do Painel Gift (Tapete e AP)
AddBtn("Presentear: Tapete", GiftPanel, function() SimularPresente("Tapete") end)
AddBtn("Presentear: AP (All Passes)", GiftPanel, function() SimularPresente("AP") end)

-- Funções do Painel Robux (Flash TP e Ragdoll)
AddBtn("Flash TP [P]", RobuxPanel, function()
    if player.Character:FindFirstChild("Brainrot") then
        player.Character.HumanoidRootPart.CFrame *= CFrame.new(0, 0, -80)
    end
end)

AddBtn("Ragdoll", RobuxPanel, function()
    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    task.wait(2)
    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end)

-- Valor de Robux Fake
local rb = Instance.new("TextLabel", RobuxPanel)
rb.Size = UDim2.new(1, 0, 0, 30)
rb.Text = "Robux: 11.284"
rb.TextColor3 = Color3.new(1, 1, 0)
rb.BackgroundTransparency = 1
rb.Font = Enum.Font.GothamBold

-- Toggle com tecla P
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then sg.Enabled = not sg.Enabled end
end)
