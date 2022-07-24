ver = "build: alpha v0.00d"
messages = {"random message lol - rawr!","random message lol - uwu","random message lol - owo", "random message lol - >w<", "random message lol - okie"}

local function notify(text)
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
    
    spawn(function()
        Notif:TweenPosition(UDim2.new(0, 0, 0, 0),"Out","Quint",.3)
        wait(0.5)
        Notif:TweenPosition(UDim2.new(0, 0, 0, -100),"In","Quint",.3)
        wait(0.3)
        MoonHighNotif:Destroy()
    end)
end

if game.CoreGui:FindFirstChild("MoonHighRoot") then
    game.CoreGui:FindFirstChild("MoonHighRoot"):Destroy()
    notify("MoonHigh reloaded! | "..ver.." | "..messages[math.random(1,#messages)])
else
    notify("MoonHigh loaded! | "..ver.." | "..messages[math.random(1,#messages)])
end

local MoonHighRoot = Instance.new("ScreenGui")
local Label = Instance.new("TextLabel")
MoonHighRoot.Name = "MoonHighRoot"
MoonHighRoot.Parent = game.CoreGui
MoonHighRoot.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Label.Name = "Label"
Label.Parent = MoonHighRoot
Label.BackgroundColor3 = Color3.fromRGB(14, 12, 29)
Label.BorderColor3 = Color3.fromRGB(82, 79, 130)
Label.BackgroundTransparency = 0.25
Label.TextColor3 = Color3.fromRGB(82, 79, 130)
Label.Font = Enum.Font.RobotoMono
Label.TextSize = 14
Label.Text = "selected: none"
Label.Size = UDim2.new(0, Label.TextBounds.X + 14, 0, 22)
Label.Position = UDim2.new(0, 25, 0, 25)


local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local Mouse = Player:GetMouse()

local TargetSelected = false
local TargetRoot = nil

local function isr6()
    local hum = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum.RigType == Enum.HumanoidRigType.R6 then
        return true
    else
        return false
    end
end

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
            SavedTarget = Target.Parent.Parent.HumanoidRootPart
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

local function Clicked()
    if TargetSelected and TargetRoot then
        SavedTarget = TargetRoot
        Player.Character.HumanoidRootPart.CFrame = TargetRoot.CFrame * CFrame.new(0,0,-3) 
        notify("Teleported to: "..TargetRoot.Parent.Name)
    end    
end

--// menu func
local function OpenMenu()
    if TargetSelected and TargetRoot then
        SavedTarget = TargetRoot
        notify("Opening menu")
        
        local function closemenu()
            for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
                if v.Name == "HighMoonMenu" then
                    v:Destroy()
                end
            end
        end
        closemenu()

        --// make menu
        local HighMoonMenu = Instance.new("ScreenGui")
        local Menu = Instance.new("Frame")
        local Name = Instance.new("TextLabel")
        local holder = Instance.new("ScrollingFrame")
        local list = Instance.new("UIListLayout")
        local pad = Instance.new("UIPadding")
        
        --// define menu
        HighMoonMenu.Name = "HighMoonMenu"
        HighMoonMenu.Parent = game.CoreGui
        
        Menu.Name = "Menu"
        Menu.Parent = HighMoonMenu
        Menu.BackgroundColor3 = Color3.fromRGB(14, 12, 29)
        Menu.BackgroundTransparency = 0.250
        Menu.BorderColor3 = Color3.fromRGB(82, 79, 130)
        Menu.Position = UDim2.new(0.5, -97, 0.5, -73)
        Menu.Size = UDim2.new(0, 195, 0, 147)
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
        
        holder.Name = "holder"
        holder.Parent = Menu
        holder.BackgroundColor3 = Color3.fromRGB(14, 12, 29)
        holder.BackgroundTransparency = 1.000
        holder.BorderColor3 = Color3.fromRGB(82, 79, 130)
        holder.BorderSizePixel = 0
        holder.Position = UDim2.new(0, 0, 0, 25)
        holder.Selectable = false
        holder.Size = UDim2.new(1, 0, 1, -25)
        holder.ZIndex = -5
        holder.CanvasSize = UDim2.new(0, 0, 1, 0)
        holder.ScrollBarThickness = 0
        
        list.Name = "list"
        list.Parent = holder
        list.HorizontalAlignment = Enum.HorizontalAlignment.Center
        list.Padding = UDim.new(0, 4)
        
        pad.Name = "pad"
        pad.Parent = holder
        pad.PaddingTop = UDim.new(0, 1)
        
        local function makebtn(text, func)
        	local btn = Instance.new("TextButton")
        	
        	for i, v in pairs(holder:GetChildren())	do
        		btn.Name = i..text
        	end
        	
        	btn.Parent = holder
        	btn.Active = false
        	btn.BackgroundColor3 = Color3.fromRGB(14, 12, 29)
        	btn.BackgroundTransparency = 0.250
        	btn.BorderColor3 = Color3.fromRGB(82, 79, 130)
        	btn.Position = UDim2.new(0, 0, 0, 25)
        	btn.Selectable = false
        	btn.Size = UDim2.new(1, -10, 0, 20)
        	btn.ZIndex = -5
        	btn.Font = Enum.Font.RobotoMono
        	btn.Text = text
        	btn.TextColor3 = Color3.fromRGB(136, 132, 217)
        	btn.TextSize = 14.000
            btn.Modal = true
        	
        	func = func or function() end
        	btn.MouseButton1Click:connect(function()
    			spawn(func)
    		end)
        end
        --// make buttons and script
        makebtn("Goto", function()
            Player.Character.HumanoidRootPart.CFrame = SavedTarget.CFrame * CFrame.new(0,0,-3) 
            notify("Teleported to: "..SavedTarget.Parent.Name)
        	closemenu()
        end)
        
        makebtn("Bring", function()
            if #game.Players.LocalPlayer.Backpack:GetChildren() <= 1 and not workspace:FindFirstChild("Handle") then	
                notify("Not enough tools!")
                return nil
            end

            notify("Bringing to: "..SavedTarget.Parent.Name)

            --// why did u have to leak this shown, lol
            local plr = game.Players.LocalPlayer
            local backpack = plr.Backpack
            local character = plr.Character
            local hrp = character.HumanoidRootPart

            local tool = character:FindFirstChildOfClass("Tool") or backpack:FindFirstChildOfClass("Tool")
            if #game.Players.LocalPlayer.Backpack:GetChildren() < 2 and workspace:FindFirstChild("Handle") then	
                firetouchinterest(game:GetService("Workspace").Handle,hrp,0)
                firetouchinterest(game:GetService("Workspace").Handle,hrp,1)
                character.ChildAdded:wait()
                task.wait()
            end
            for i,v in pairs(character:GetChildren()) do
                if v:IsA("Tool") then
                    v.Parent = backpack
                    v.Parent = character
                    v.Parent = backpack
                end
            end

            local attachtool
            for i,v in pairs(backpack:GetChildren()) do
                if v:IsA("Tool") and v ~= tool then
                    attachtool = v
                    break
                end
            end
            tool.Parent = backpack

            attachtool.Parent = character
            attachtool.Parent = tool
            attachtool.Parent = backpack
            attachtool.Parent = character.Head

            local rarm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightHand")
            local rgrip = Instance.new("Weld")
            rgrip.Name = "RightGrip"
            rgrip.Part0 = rarm
            rgrip.Part1 = attachtool.Handle
            rgrip.C0 = CFrame.new(0, 3, -5) * CFrame.Angles(math.rad(0),0,0)
            rgrip.C1 = attachtool.Grip
            rgrip.Parent = rarm

            wait()

            firetouchinterest(attachtool.Handle, SavedTarget,0)
            firetouchinterest(attachtool.Handle, SavedTarget,1)

            wait(0.5)

            if isr6() then
                game:GetService("Players").LocalPlayer.Character['Right Arm'].RightGrip:Destroy()
            else
                game:GetService("Players").LocalPlayer.Character['RightHand'].RightGrip:Destroy()
            end
        	closemenu()
        end)
        
        makebtn("Attach", function()
            if #game.Players.LocalPlayer.Backpack:GetChildren() <= 1 and not workspace:FindFirstChild("Handle") then	
                notify("Not enough tools!")
                return nil
            end

            notify("Bringing to: "..SavedTarget.Parent.Name)

            --// why did u have to leak this shown, lol
            local plr = game.Players.LocalPlayer
            local backpack = plr.Backpack
            local character = plr.Character
            local hrp = character.HumanoidRootPart

            local tool = character:FindFirstChildOfClass("Tool") or backpack:FindFirstChildOfClass("Tool")
            if #game.Players.LocalPlayer.Backpack:GetChildren() < 2 and workspace:FindFirstChild("Handle") then	
                firetouchinterest(game:GetService("Workspace").Handle,hrp,0)
                firetouchinterest(game:GetService("Workspace").Handle,hrp,1)
                character.ChildAdded:wait()
                task.wait()
            end
            for i,v in pairs(character:GetChildren()) do
                if v:IsA("Tool") then
                    v.Parent = backpack
                    v.Parent = character
                    v.Parent = backpack
                end
            end

            local attachtool
            for i,v in pairs(backpack:GetChildren()) do
                if v:IsA("Tool") and v ~= tool then
                    attachtool = v
                    break
                end
            end
            tool.Parent = backpack

            attachtool.Parent = character
            attachtool.Parent = tool
            attachtool.Parent = backpack
            attachtool.Parent = character.Head

            local rarm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightHand")
            local rgrip = Instance.new("Weld")
            rgrip.Name = "RightGrip"
            rgrip.Part0 = rarm
            rgrip.Part1 = attachtool.Handle
            rgrip.C0 = CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-90),0,0)
            rgrip.C1 = attachtool.Grip
            rgrip.Parent = rarm

            wait()

            firetouchinterest(attachtool.Handle, SavedTarget,0)
            firetouchinterest(attachtool.Handle, SavedTarget,1)

        	closemenu()
        end)
        
        makebtn("Fling", function()
            spawn(function()
                --// using very modified iy method
                --~ this took WAYY longer than it should have to make
                notify("Fling'n: "..SavedTarget.Parent.Name)

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
        	closemenu()
        end)
        
        makebtn("Kill", function()
        	print("Hello world!")
        	closemenu()
        end)

        makebtn("Close", function()
        	notify("Closing menu")
        	closemenu()
        end)
    end    
end

Mouse.Move:Connect(mouseMoved)
Mouse.Button1Down:Connect(Clicked)
Mouse.Button2Down:Connect(OpenMenu)
