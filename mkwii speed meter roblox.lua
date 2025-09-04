local player = game.Players.LocalPlayer
local sc = Instance.new("ScreenGui")
sc.Name = "I9SkHxF"
sc.Parent = game:GetService("CoreGui")

local holder = Instance.new("Frame")
holder.Name = "UiOl#Sz8G"
holder.Size = UDim2.new(0, 200, 0, 50)
holder.Position = UDim2.new(0.7, 0, 0.8, 0)
holder.BackgroundTransparency = 1
holder.ZIndex = 123456789
holder.Parent = sc

local textHolder = Instance.new("Frame")
textHolder.Size = UDim2.new(1, 0, 1, 0)
textHolder.BackgroundTransparency = 1
textHolder.Parent = holder

local imgdata0 = game:HttpGet("https://raw.githubusercontent.com/water5202/sb-stuff/refs/heads/main/asset/NFont0.png")
writefile("NFont0.png", imgdata0)

local imgdata1 = game:HttpGet("https://raw.githubusercontent.com/water5202/sb-stuff/refs/heads/main/asset/NFont1.png")
writefile("NFont1.png", imgdata1)

local imgdata2 = game:HttpGet("https://raw.githubusercontent.com/water5202/sb-stuff/refs/heads/main/asset/NFont2.png")
writefile("NFont2.png", imgdata2)

local imgdata3 = game:HttpGet("https://raw.githubusercontent.com/water5202/sb-stuff/refs/heads/main/asset/NFont3.png")
writefile("NFont3.png", imgdata3)

local imgdata4 = game:HttpGet("https://raw.githubusercontent.com/water5202/sb-stuff/refs/heads/main/asset/NFont4.png")
writefile("NFont4.png", imgdata4)

local imgdata5 = game:HttpGet("https://raw.githubusercontent.com/water5202/sb-stuff/refs/heads/main/asset/NFont5.png")
writefile("NFont5.png", imgdata3)

local imgdata6 = game:HttpGet("https://raw.githubusercontent.com/water5202/sb-stuff/refs/heads/main/asset/NFont6.png")
writefile("NFont6.png", imgdata6)

local imgdata7 = game:HttpGet("https://raw.githubusercontent.com/water5202/sb-stuff/refs/heads/main/asset/NFont7.png")
writefile("NFont7.png", imgdata7)

local imgdata8 = game:HttpGet("https://raw.githubusercontent.com/water5202/sb-stuff/refs/heads/main/asset/NFont8.png")
writefile("NFont8.png", imgdata8)

local imgdata9 = game:HttpGet("https://raw.githubusercontent.com/water5202/sb-stuff/refs/heads/main/asset/NFont9.png")
writefile("NFont9.png", imgdata9)

local imgdatad = game:HttpGet("https://raw.githubusercontent.com/water5202/sb-stuff/refs/heads/main/asset/NFontDecimal.png")
writefile("NFontDecimal.png", imgdatad)

local digitImages = {
    ["0"] = getcustomasset("NFont0.png"),
    ["1"] = getcustomasset("NFont1.png"),
    ["2"] = getcustomasset("NFont2.png"),
    ["3"] = getcustomasset("NFont3.png"),
    ["4"] = getcustomasset("NFont4.png"),
    ["5"] = getcustomasset("NFont5.png"),
    ["6"] = getcustomasset("NFont6.png"),
    ["7"] = getcustomasset("NFont7.png"),
    ["8"] = getcustomasset("NFont8.png"),
    ["9"] = getcustomasset("NFont9.png"),
    ["."] = getcustomasset("NFontDecimal.png"),
}

local function renderNumber(num)
    textHolder:ClearAllChildren()
    local str = tostring(num)
    local xOffset = 0
    for i = 1, #str do
        local char = string.sub(str, i, i)
        local img = digitImages[char]
        if img then
            local digitLabel = Instance.new("ImageLabel")
            digitLabel.Image = img
            digitLabel.Size = UDim2.new(0, 50, 0, 50)
            digitLabel.Position = UDim2.new(0, xOffset, 0, 0)
            digitLabel.BackgroundTransparency = 1
            digitLabel.Parent = textHolder
            xOffset = xOffset + 20
        end
    end
end

local RunService = game:GetService("RunService")
local lastPos = nil
local lastTime = tick()
local lastUpdate = 0
local UPDATE_INTERVAL = 0.05
local char
local root

RunService.RenderStepped:Connect(function()
    char = player.Character
    root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        local currentPos = root.Position
        local currentTime = tick()
        if lastPos then
            local dist = (currentPos - lastPos).Magnitude
            local dt = currentTime - lastTime
            if dt > 0 then
                local sps = dist / dt
                if currentTime - lastUpdate >= UPDATE_INTERVAL then
                    local spsText = string.format("%.1f", sps)
                    renderNumber(spsText)
                    lastUpdate = currentTime
                end
            end
        end
        lastPos = currentPos
        lastTime = currentTime
    end
end)
