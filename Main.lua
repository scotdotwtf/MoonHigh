--// unimportant vars
ver = "build: alpha v0.01b rewrite"
messages = {"random message lol - rawr!","random message lol - uwu","random message lol - owo", "random message lol - >w<", "random message lol - okie"}

--// Wait for game to load if someone is using autoexc
repeat wait() until game:IsLoaded()

--// notify func
local function Notify(text)
    wait()
    for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "MoonHighNotif" then
            v:Destroy()
        end
    end
    
    local MoonHighNotif = Instance.new("ScreenGui")
    local Notif = Instance.new("TextLabel")
    
    MoonHighNotif.Name = "MoonHighNotif"
    MoonHighNotif.Parent = game.CoreGui

    Notif.Name = "Notif"
    Notif.Parent = MoonHighNotif
    Notif.Position = UDim2.new(0, 0, 0, -100)
    Notif.BackgroundColor3 = Color3.fromRGB(14, 12, 29)
    Notif.BackgroundTransparency = 0.500
    Notif.BorderColor3 = Color3.fromRGB(82, 79, 130)
    Notif.Size = UDim2.new(1, 0, 0, 25)
    Notif.ZIndex = 203
    Notif.Font = Enum.Font.RobotoMono
    Notif.Text = text
    Notif.TextColor3 = Color3.fromRGB(136, 132, 217)
    Notif.TextSize = 14.000
    
    pcall(function()
        Notif:TweenPosition(UDim2.new(0, 0, 0, 0),"Out","Quint",.3)
        wait(0.5)
        Notif:TweenPosition(UDim2.new(0, 0, 0, -100),"In","Quint",.3)
        wait(0.3)
        MoonHighNotif:Destroy()
    end)
end

--// check if it already exist
if game:GetService("CoreGui"):FindFirstChild("MoonHighRoot") then
    game.CoreGui:FindFirstChild("MoonHighRoot"):Destroy()
    Notify("MoonHigh reloaded! | "..ver.." | "..messages[math.random(1,#messages)])
else
    Notify("MoonHigh loaded! | "..ver.." | "..messages[math.random(1,#messages)])
end

--// make ui
local MoonHighRoot = Instance.new("ScreenGui")
local Label = Instance.new("TextLabel")
local Stroke = Instance.new("UIStroke")
local Rounding = Instance.new("UICorner")

MoonHighRoot.Name = "MoonHighRoot"
MoonHighRoot.Parent = game.CoreGui
MoonHighRoot.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Label.Name = "Label"
Label.Parent = MoonHighRoot
Label.BackgroundColor3 = Color3.fromRGB(14, 12, 29)
Label.BorderColor3 = Color3.fromRGB(82, 79, 130)
Label.BackgroundTransparency = 0.25
Label.TextColor3 = Color3.fromRGB(136, 132, 217)
Label.Font = Enum.Font.RobotoMono
Label.TextSize = 14
Label.Text = "selected: none"
Label.Size = UDim2.new(0, Label.TextBounds.X + 14, 0, 22)
Label.Position = UDim2.new(0, 25, 0, 25)
Label.Visible = false

Stroke.Parent = Label
Stroke.Color = Color3.fromRGB(82, 79, 130)
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

Rounding.Parent = Label
Rounding.CornerRadius = UDim.new(0, 6)

--// useful vars
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local TargetSelected = false
local TargetRoot = nil
local getasset = getsynasset or getcustomasset

makefolder("moonhigh")
writefile("moonhigh/logo.png", game:HttpGet("https://raw.githubusercontent.com/specowos/MoonHigh/main/Media/moonhigh.png"))

--// watermark
local logo = Instance.new("ImageLabel")
logo.Parent = MoonHighRoot
logo.Name = "logo"
logo.Image = getasset("moonhigh/logo.png")
logo.Size = UDim2.new(0, 150, 0, 150)
logo.Position = UDim2.new(0, 15, 1, -165)
logo.BackgroundTransparency = 1

--// tween
local TweenService = game:GetService("TweenService")

local goal1 = {Rotation = 6}
local goal2 = {Rotation = -6}

local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

local tween1 = TweenService:Create(logo, tweenInfo, goal1)
local tween2 = TweenService:Create(logo, tweenInfo, goal2)

spawn(function()
	while wait() do
		tween1:Play()
		wait(2)
		tween2:Play()
		wait(2)
	end
end)

--// cursor follow func
local function checkForPlayer(Part)
    if Players:GetPlayerFromCharacter(Part) then
        return true
    else
        return false
    end
end

local function setText(NewText)
    Label.Text = "selected : "..NewText
    Label.Size = UDim2.new(0, Label.TextBounds.X + 14, 0, 22)
end    

local function mouseMoved()
    local Target = Mouse.Target
    
    Label.Position = UDim2.new(0,Mouse.X + 15,0,Mouse.Y + 20)
    
    if Target then
        if Target.Parent:IsA("Accessory") and checkForPlayer(Target.Parent.Parent) then
            setText(Target.Parent.Parent.Name)
            pcall(function()
                SavedTarget = Target.Parent.Parent.HumanoidRootPart
            end)
            TargetSelected = true
            TargetRoot = Target.Parent.Parent.HumanoidRootPart
            Label.Visible = true
        elseif Target.Parent:IsA("Tool") and checkForPlayer(Target.Parent.Parent) then
            setText(Target.Parent.Parent.Name)
            SavedTarget = Target.Parent.Parent.HumanoidRootPart
            TargetSelected = true
            TargetRoot = Target.Parent.Parent.HumanoidRootPart
            Label.Visible = true
        elseif checkForPlayer(Target.Parent) then
            setText(Target.Parent.Name)
            SavedTarget = Target.Parent.HumanoidRootPart
            TargetSelected = true
            TargetRoot = Target.Parent.HumanoidRootPart
            Label.Visible = true
        else
            setText("None")
            TargetSelected = false
            TargetRoot = nil
            Label.Visible = false
        end
    else
        setText("None")
        TargetSelected = false
        TargetRoot = nil
        Label.Visible = false
    end
end

local function GameEvent(gameid, func)
    if game.PlaceId == gameid then
        Notify("Game detected!, loading tools.")
        func = func or function() end
        spawn(func)
    end
end

GameEvent(155615604, function()
    local guns = {"Remington 870","M9","AK-47"}
    while wait() do
        game.Workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver[guns[math.random(#guns)]].ITEMPICKUP)
    end
end)

--// left click func
local function Clicked()
    if TargetSelected and TargetRoot then
        SavedTarget = TargetRoot
        Player.Character.HumanoidRootPart.CFrame = TargetRoot.CFrame * CFrame.new(0, 0, 3) 
        Notify("Teleported to: "..TargetRoot.Parent.Name)
    end    
end

local function OpenMenu()
    if TargetSelected and TargetRoot then
        --// Saved vars
        SavedTarget = TargetRoot

        --// Useful funcs
        local function CheckR6()
            local hum = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum.RigType == Enum.HumanoidRigType.R6 then
                return true
            else
                return false
            end
        end

        local function DestroyMenus()
            for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
                if v.Name == "HighMoonMenu" then
                    v:Destroy()
                end
            end
        end

        DestroyMenus()

        --// Make menu
        local HighMoonMenu = Instance.new("ScreenGui")
        local Menu = Instance.new("Frame")
        local MStroke = Instance.new("UIStroke")
        local MRounding = Instance.new("UICorner")
        local Name = Instance.new("TextLabel")
        local Scroll = Instance.new("ScrollingFrame")
        local List = Instance.new("UIListLayout")
        local Pad = Instance.new("UIPadding")

        HighMoonMenu.Name = "HighMoonMenu"
        HighMoonMenu.Parent = game:GetService("CoreGui")

        Menu.Name = "Menu"
        Menu.Parent = HighMoonMenu
        Menu.BackgroundColor3 = Color3.fromRGB(14, 12, 29)
        Menu.BackgroundTransparency = 0.25
        Menu.Position = UDim2.new(0.5, -97, 0.5, -72)
        Menu.Size = UDim2.new(0, 195, 0, 146)
        Menu.ZIndex = -5
        
        Name.Name = "Name"
        Name.Parent = Menu
        Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Name.BackgroundTransparency = 1.000
        Name.Size = UDim2.new(1, 0, 0, 25)
        Name.ZIndex = 0
        Name.Font = Enum.Font.RobotoMono
        Name.Text = SavedTarget.Parent.Name
        Name.TextColor3 = Color3.fromRGB(136, 132, 217)
        Name.TextSize = 14.000

        MStroke.Parent = Menu
        MStroke.Color = Color3.fromRGB(82, 79, 130)

        MRounding.Parent = Menu
        MRounding.CornerRadius = UDim.new(0, 6)

        Scroll.Name = "Scroll"
        Scroll.Parent = Menu
        Scroll.BackgroundTransparency = 1.000
        Scroll.Position = UDim2.new(0, 0, 0, 25)
        Scroll.Selectable = false
        Scroll.Size = UDim2.new(1, 0, 1, -25)
        Scroll.ZIndex = -5
        Scroll.CanvasSize = UDim2.new(0, 0, 1.1, 0)
        Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Scroll.ScrollBarThickness = 12
        Scroll.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
        Scroll.ScrollBarImageTransparency = 0.5
        Scroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
        Scroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
        Scroll.BorderSizePixel = 0
        
        List.Name = "list"
        List.Parent = Scroll
        List.HorizontalAlignment = Enum.HorizontalAlignment.Left
        List.Padding = UDim.new(0, 4)
        
        Pad.Name = "pad"
        Pad.Parent = Scroll
        Pad.PaddingTop = UDim.new(0, 1)
        Pad.PaddingLeft = UDim.new(0, 4)

        local function makebtn(Text, Func)
            local Button = Instance.new("TextButton")
            local MStroke = Instance.new("UIStroke")
            local MRounding = Instance.new("UICorner")
            
            for i, v in pairs(Scroll:GetChildren())	do
                Button.Name = i+10
            end
            
            Button.Parent = Scroll
            Button.Active = false
            Button.BackgroundColor3 = Color3.fromRGB(14, 12, 29)
            Button.BackgroundTransparency = 0.250
            Button.Position = UDim2.new(0, 0, 0, 25)
            Button.Selectable = false
            Button.Size = UDim2.new(1, -16, 0, 24)
            Button.ZIndex = -5
            Button.Font = Enum.Font.RobotoMono
            Button.Text = Text
            Button.TextColor3 = Color3.fromRGB(136, 132, 217)
            Button.TextSize = 14.000
            Button.Modal = true
            
            MStroke.Parent = Button
            MStroke.Color = Color3.fromRGB(82, 79, 130)
            MStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            MRounding.Parent = Button
            MRounding.CornerRadius = UDim.new(0, 4)

            Func = Func or function() end
            Button.MouseButton1Click:connect(function()
                spawn(Func)
                DestroyMenus()
            end)
        end

        --// This is where the rewrite really comes in, with these funcs
        local function Stopanims()
            --// Thanks IY!
            local Hum = Player.Character:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
            for i,v in next, Hum:GetPlayingAnimationTracks() do
                v:Stop()
            end
        end

        local function GripToPos(Info)
            if #game.Players.LocalPlayer.Backpack:GetChildren() == 0 and not workspace:FindFirstChild("Handle") then	
                Notify("Not enough tools!")
                return nil
            end

            --// why did u have to leak this shown, lol
            local plr = game.Players.LocalPlayer
            local backpack = plr.Backpack
            local character = plr.Character
            local hrp = character.HumanoidRootPart
            local targetinstance = character.Humanoid
            
            local tool = character:FindFirstChildOfClass("Tool") or backpack:FindFirstChildOfClass("Tool")
            local rarm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightHand")
            
            local function genrgrip(tool)
                local rgrip = Instance.new("Weld")
                rgrip.Name = "RightGrip"
                rgrip.Part0 = rarm
                rgrip.Part1 = tool.Handle
                rgrip.C0 = Info.ToCFrame
                rgrip.C1 = tool.Grip
                rgrip.Parent = rarm
                return rgrip
            end
            
            genrgrip(tool)
            tool.Parent = backpack
            tool.Parent = targetinstance
            tool.Parent = character
            tool.Handle:BreakJoints()
            tool.Parent = backpack
            tool.Parent = targetinstance
            genrgrip(tool)

            wait()

            SavedTarget.Parent.Humanoid.PlatformStand = true

            --// anim system
            if CheckR6() then
                if Info.AnimR6 ~= "None" then
                    local anim = Instance.new("Animation")

                    if Info.AnimR6 == "Tool" then
                        anim.AnimationId = "rbxassetid://182393478"
                    else
                        anim.AnimationId = Info.AnimR6
                    end

                    local track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
                    track:Play(.1, 1, 1)
                end
            else
                if Info.AnimR15 ~= "None" then
                    local anim = Instance.new("Animation")

                    if Info.AnimR15 == "Tool" then
                        anim.AnimationId = "rbxassetid://507768375"
                    else
                        anim.AnimationId = Info.AnimR15
                    end

                    local track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
                    track:Play(.1, 1, 1)
                end
            end

            firetouchinterest(tool.Handle, SavedTarget,0)
            firetouchinterest(tool.Handle, SavedTarget,1)

            wait(0.5)

            if Info.Drop then
                if CheckR6() then
                    Player.Character['Right Arm'].RightGrip:Destroy()
                else
                    Player.Character['RightHand'].RightGrip:Destroy()
                end
            end
        end

        makebtn("Goto", function()
            Player.Character.HumanoidRootPart.CFrame = SavedTarget.CFrame * CFrame.new(0,0,3) 
        	Notify("Teleporting to: "..SavedTarget.Parent.Name)
        end)

        makebtn("Bring", function()
            game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
            Stopanims()
            GripToPos({
                ["ToCFrame"] = CFrame.new(0, 3, -5) * CFrame.Angles(math.rad(0),0,0),
                ["Drop"] = true,
                ["AnimR6"] = "None",
                ["AnimR15"] = "None"
            })     
        	Notify("Bringing: "..SavedTarget.Parent.Name)
            game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
        end)

        makebtn("Skydive", function()
            game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
            Stopanims()
            GripToPos({
                ["ToCFrame"] = CFrame.new(0, 150, 0) * CFrame.Angles(math.rad(-180),0,0),
                ["Drop"] = true,
                ["AnimR6"] = "None",
                ["AnimR15"] = "None"
            })     
        	Notify(SavedTarget.Parent.Name.." is skydiving")
            game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
        end)

        makebtn("Attach", function()
            GripToPos({
                ["ToCFrame"] = CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-90),0,0),
                ["Drop"] = false,
                ["AnimR6"] = "None",
                ["AnimR15"] = "None"
            })     
        	Notify("Attaching: "..SavedTarget.Parent.Name)
        end)

        makebtn("Control", function()
            GripToPos({
                ["ToCFrame"] = CFrame.new(0, -1.15, 0) * CFrame.Angles(math.rad(-90),0,0),
                ["Drop"] = false,
                ["AnimR6"] = "Tool",
                ["AnimR15"] = "Tool"
            })     
        	Notify("Controling: "..SavedTarget.Parent.Name)
        end)

        makebtn("Bodyguard", function()
            GripToPos({
                ["ToCFrame"] = CFrame.new(6, -1, 0) * CFrame.Angles(math.rad(-90),0,0),
                ["Drop"] = false,
                ["AnimR6"] = "Tool",
                ["AnimR15"] = "Tool"
            })     
        	Notify(SavedTarget.Parent.Name.." is your bodyguard")
        end)

        makebtn("Hold", function()
            GripToPos({
                ["ToCFrame"] = CFrame.new(1.5, -3, -0.5) * CFrame.Angles(math.rad(-90),0,0),
                ["Drop"] = false,
                ["AnimR6"] = "Tool",
                ["AnimR15"] = "Tool"
            })     
        	Notify("Holding: "..SavedTarget.Parent.Name)
        end)

        makebtn("Bang", function()
            GripToPos({
                ["ToCFrame"] = CFrame.new(0, 2.5, 2.5) * CFrame.Angles(math.rad(125),0,0),
                ["Drop"] = false,
                ["AnimR6"] = "rbxassetid://148840371",
                ["AnimR15"] = "rbxassetid://5918726674"
            })     
        	Notify("Bang'n: "..SavedTarget.Parent.Name)
        end)

        makebtn("Fling", function()
            spawn(function()
                --// using very modified iy method
                --~ this took WAYY longer than it should have to make
                local target = SavedTarget.Parent
                local me = game.Players.LocalPlayer.Character

                for i, v in pairs(me:GetChildren()) do
                    if v:IsA("Tool") then
                        v.Parent = game.Players.LocalPlayer.Backpack
                    end
                end

                local bodyvel = Instance.new("BodyAngularVelocity")
                bodyvel.MaxTorque = Vector3.new(1, 1, 1) * math.huge
                bodyvel.P = math.huge
                bodyvel.AngularVelocity = Vector3.new(0, 9e5, 0)
                bodyvel.Parent = me.HumanoidRootPart

                for i, v in next, me:GetChildren() do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                        v.Massless = true
                        v.Velocity = Vector3.new(0, 0, 0)
                    end
                end

                local function stopthisfunc()
                    for i, v in next, me:GetChildren() do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end

                stopconnection = game.RunService.Stepped:Connect(stopthisfunc)

                local function endthemfunc()
                    function endthem()
                        me.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame - Vector3.new(-0.5, 0, 0)
                    end
                    connection = game.RunService.Heartbeat:Connect(endthem)
                    wait(2)
                    connection:Disconnect()
                end

                endthemfunc()
                stopconnection:Disconnect()

                bodyvel:Destroy()

                me.Humanoid.Health = 0
            end)
            Notify("Fling'n: "..SavedTarget.Parent.Name)
        end)

        makebtn("Kill", function()
            GripToPos({
                ["ToCFrame"] = CFrame.new(0, -99, 0) * CFrame.Angles(math.rad(0),0,0),
                ["Drop"] = true,
                ["AnimR6"] = "None",
                ["AnimR15"] = "None"
            })     
        	Notify("Killing: "..SavedTarget.Parent.Name)
        end)

        makebtn("Close", function()
            Notify("Closing menu")
        end)
    end
end

--// complete with mouse funcs
Mouse.Move:Connect(mouseMoved)
Mouse.Button1Down:Connect(Clicked)
Mouse.Button2Down:Connect(OpenMenu)