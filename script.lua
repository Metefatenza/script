local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Tabs = Instance.new("Frame")
local AimbotTab = Instance.new("TextButton")
local ESPTab = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
 
ScreenGui.Parent = game.CoreGui
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Parent = ScreenGui
 
Title.Text = "Cheat Menu"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = MainFrame
 
Tabs.Size = UDim2.new(1, 0, 0, 30)
Tabs.Position = UDim2.new(0, 0, 0, 30)
Tabs.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Tabs.Parent = MainFrame
 
AimbotTab.Text = "Aimbot"
AimbotTab.Size = UDim2.new(0.5, 0, 1, 0)
AimbotTab.Parent = Tabs
AimbotTab.MouseButton1Click:Connect(function()
    ContentFrame:ClearAllChildren()
    CreateAimbotOptions()
end)
 
ESPTab.Text = "ESP"
ESPTab.Size = UDim2.new(0.5, 0, 1, 0)
ESPTab.Position = UDim2.new(0.5, 0, 0, 0)
ESPTab.Parent = Tabs
ESPTab.MouseButton1Click:Connect(function()
    ContentFrame:ClearAllChildren()
    CreateESPOptions()
end)
 
ContentFrame.Size = UDim2.new(1, 0, 1, -60)
ContentFrame.Position = UDim2.new(0, 0, 0, 60)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ContentFrame.Parent = MainFrame
 
function CreateAimbotOptions()
    local SilentAimToggle = Instance.new("TextButton")
    SilentAimToggle.Text = "Silent Aim"
    SilentAimToggle.Size = UDim2.new(1, 0, 0, 30)
    SilentAimToggle.Parent = ContentFrame
    SilentAimToggle.MouseButton1Click:Connect(function()
        _G.SilentAim = not _G.SilentAim
        SilentAimToggle.Text = "Silent Aim: " .. (_G.SilentAim and "ON" or "OFF")
    end)
end
 
function CreateESPOptions()
    local HitboxESP = Instance.new("TextButton")
    HitboxESP.Text = "Hitbox ESP"
    HitboxESP.Size = UDim2.new(1, 0, 0, 30)
    HitboxESP.Parent = ContentFrame
    HitboxESP.MouseButton1Click:Connect(function()
        _G.HitboxESP = not _G.HitboxESP
        HitboxESP.Text = "Hitbox ESP: " .. (_G.HitboxESP and "ON" or "OFF")
    end)
 
    local BoxESP = Instance.new("TextButton")
    BoxESP.Text = "Box ESP"
    BoxESP.Size = UDim2.new(1, 0, 0, 30)
    BoxESP.Position = UDim2.new(0, 0, 0, 30)
    BoxESP.Parent = ContentFrame
    BoxESP.MouseButton1Click:Connect(function()
        _G.BoxESP = not _G.BoxESP
        BoxESP.Text = "Box ESP: " .. (_G.BoxESP and "ON" or "OFF")
    end)
 
    local NameESP = Instance.new("TextButton")
    NameESP.Text = "Name ESP"
    NameESP.Size = UDim2.new(1, 0, 0, 30)
    NameESP.Position = UDim2.new(0, 0, 0, 60)
    NameESP.Parent = ContentFrame
    NameESP.MouseButton1Click:Connect(function()
        _G.NameESP = not _G.NameESP
        NameESP.Text = "Name ESP: " .. (_G.NameESP and "ON" or "OFF")
    end)
end
 
game:GetService("RunService").Heartbeat:Connect(function()
    if _G.SilentAim then
        local targetPlayer = nil
        local closestDistance = math.huge
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    targetPlayer = player
                end
            end
        end
        if targetPlayer then
            -- Get target position
            local target = targetPlayer.Character.HumanoidRootPart.Position

            -- Set the camera to look at the target, without moving the player's character
            local camera = game:GetService("Workspace").CurrentCamera
            local playerCharacter = game.Players.LocalPlayer.Character
            local aimCFrame = CFrame.lookAt(playerCharacter.HumanoidRootPart.Position, target)
            
            -- Set the camera's orientation to aim at the target
            camera.CFrame = CFrame.new(camera.CFrame.Position, aimCFrame.Position)
        end
    end
end)
 
game:GetService("RunService").RenderStepped:Connect(function()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local character = player.Character
            local rootPart = character.HumanoidRootPart
            if _G.HitboxESP then
                -- Hitbox ESP: Kutu görünür
                if not character:FindFirstChild("HitboxESPPart") then
                    local hitboxPart = Instance.new("Part")
                    hitboxPart.Name = "HitboxESPPart"
                    hitboxPart.Size = Vector3.new(6, 12, 6)  -- Increase the size to make the hitbox larger
                    hitboxPart.Position = rootPart.Position
                    hitboxPart.Transparency = 0.5
                    hitboxPart.Color = Color3.fromRGB(255, 0, 0)
                    hitboxPart.Parent = character
                end
            elseif character:FindFirstChild("HitboxESPPart") then
                character.HitboxESPPart:Destroy()
            end
 
            if _G.BoxESP then
                -- Box ESP: Karakter etrafında bir kutu
                if not character:FindFirstChild("BoxESP") then
                    local box = Instance.new("Highlight")
                    box.Name = "BoxESP"
                    box.FillTransparency = 0.8
                    box.OutlineColor = Color3.fromRGB(0, 255, 0)
                    box.Parent = character
                end
            elseif character:FindFirstChild("BoxESP") then
                character.BoxESP:Destroy()
            end
 
            if _G.NameESP then
                -- Name ESP: Karakterin ismini göster
                if not character:FindFirstChild("NameTag") then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "NameTag"
                    billboard.Adornee = character:FindFirstChild("Head")
                    billboard.Size = UDim2.new(0, 100, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = character
 
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = player.Name
                    label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    label.TextScaled = true
                    label.Font = Enum.Font.GothamBold
                    label.Parent = billboard
                end
            elseif character:FindFirstChild("NameTag") then
                character.NameTag:Destroy()
            end
        end
    end
end)
