local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
sg.Name = "LK7_KurdStyle"
sg.ResetOnSpawn = false

local VALOR_ROBUX = 100000
local TECLA_TOGGLE = Enum.KeyCode.P

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 550, 0, 350)
Main.Position = UDim2.new(0.5, -275, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 10)

local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "LK7 HUB - 100K EDITION"
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local Sidebar = Instance.new("ScrollingFrame", Main)
Sidebar.Size = UDim2.new(0, 120, 1, -60)
Sidebar.Position = UDim2.new(0, 10, 0, 50)
Sidebar.BackgroundTransparency = 1
Sidebar.ScrollBarThickness = 0
Sidebar.CanvasSize = UDim2.new(0, 0, 1.2, 0)

local SideLayout = Instance.new("UIListLayout", Sidebar)
SideLayout.Padding = UDim.new(0, 5)

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -150, 1, -70)
Content.Position = UDim2.new(0, 140, 0, 60)
Content.BackgroundColor3 = Color3.fromRGB(20, 21, 28)
local ContentCorner = Instance.new("UICorner", Content)
ContentCorner.CornerRadius = UDim.new(0, 8)

local ContentLayout = Instance.new("UIGridLayout", Content)
ContentLayout.CellSize = UDim2.new(0.46, 0, 0, 40)
ContentLayout.CellPadding = UDim2.new(0.04, 0, 0.05, 0)
ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function CreateTab(name)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 26, 35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    local bCorner = Instance.new("UICorner", btn)
    bCorner.CornerRadius = UDim.new(0, 6)
    return btn
end

CreateTab("Player")
CreateTab("Visual")
CreateTab("Admin")
CreateTab("Fun")

local function GetTarget()
    local text = "all"
    local targets = {}
    for _, p in pairs(game.Players:GetPlayers()) do
        if text == "all" or p.Name:lower():find(text) or p.DisplayName:lower():find(text) then
            table.insert(targets, p)
        end
    end
    return targets
end

local function SendVisualChat(msg)
    local tList = GetTarget()
    for _, p in pairs(tList) do
        if p.Character and p.Character:FindFirstChild("Head") then
            game:GetService("Chat"):Chat(p.Character.Head, msg, "White")
        end
    end
end

local function AtivarSuperVisual()
    VALOR_ROBUX = 100000
    task.spawn(function()
        while true do
            for _, v in pairs(player.PlayerGui:GetDescendants()) do
                if v:IsA("TextLabel") or v:IsA("TextButton") then
                    if v.Text:find("R%$") or v.Name:lower():find("robux") or v.Text:lower():find("robux") then
                        v.Text = "R$ 100.000"
                    end
                end
                if v:IsA("TextButton") and not v:GetAttribute("Hooked") then
                    local t = v.Text:lower()
                    if t:find("buy") or t:find("comprar") or t:find("purchase") or t:find("obter") then
                        v:SetAttribute("Hooked", true)
                        v.MouseButton1Click:Connect(function()
                            v.Text = "COMPRADO! (V)"
                            task.wait(1.5)
                            game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                                Text = "[LK7] Item Adicionado ao Inventário (VISUAL)",
                                Color = Color3.new(0, 1, 0)
                            })
                        end)
                    end
                end
            end
            task.wait(1)
        end
    end)
end

local function CreateAction(name, callback)
    local btn = Instance.new("TextButton", Content)
    btn.BackgroundColor3 = Color3.fromRGB(30, 31, 40)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    local cCorner = Instance.new("UICorner", btn)
    cCorner.CornerRadius = UDim.new(0, 5)
    btn.MouseButton1Click:Connect(callback)
end

CreateAction("ATIVAR 100K VISUAL", AtivarSuperVisual)
CreateAction("Ragdoll (Safe)", function()
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Physics) task.wait(2) hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
end)
CreateAction("Rocket (Anti-Death)", function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Velocity = Vector3.new(0, 60, 0) task.wait(1.5) bv:Destroy()
    end
end)
CreateAction("Jail All (5s)", function()
    for _, t in pairs(game.Players:GetPlayers()) do
        if t ~= player and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
            task.spawn(function()
                local hrp = t.Character.HumanoidRootPart
                local cf = hrp.CFrame
                local s = tick()
                while tick() - s < 5 do hrp.CFrame = cf task.wait(0.1) end
            end)
        end
    end
end)
CreateAction("Simular Admin", function()
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {Text = "Admin Comprado com Sucesso!", Color = Color3.new(0,1,0)})
end)
CreateAction("Chat: Obrigado", function() SendVisualChat("Obrigado") end)

local Footer = Instance.new("Frame", Main)
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.BackgroundTransparency = 1

local RobuxDisplay = Instance.new("TextLabel", Footer)
RobuxDisplay.Size = UDim2.new(1, -20, 1, 0)
RobuxDisplay.Position = UDim2.new(0, 10, 0, 0)
RobuxDisplay.BackgroundTransparency = 1
RobuxDisplay.TextColor3 = Color3.fromRGB(255, 215, 0)
RobuxDisplay.Font = Enum.Font.GothamBold
RobuxDisplay.TextSize = 14
RobuxDisplay.TextXAlignment = Enum.TextXAlignment.Right

spawn(function()
    while task.wait(0.1) do
        RobuxDisplay.Text = "Robux: " .. string.format('%,d', VALOR_ROBUX):gsub(",", ".")
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == TECLA_TOGGLE then Main.Visible = not Main.Visible end
end)
