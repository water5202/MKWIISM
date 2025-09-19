-- c o d i n g  i s  a d d i c t i v e
local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/water5202/Notification-Library/refs/heads/main/Notify.lua"))();
Notify.WaterNotify("MKWIISM", "Loading...", 5);

repeat wait() until game:IsLoaded();
local pgui = protectgui or (syn and syn.protect_gui) or (function() end);
local player = game.Players.LocalPlayer;
local sc = Instance.new("ScreenGui");
local RunService = game:GetService("RunService");
local tickspeed = 0.05;
local lastUpdate = 0;
local holder = Instance.new("Frame");
local textHolder = Instance.new("Frame");
local digitstuff = {};

local url = {
    ["0"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont0.png",
    ["1"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont1.png",
    ["2"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont2.png",
    ["3"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont3.png",
    ["4"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont4.png",
    ["5"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont5.png",
    ["6"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont6.png",
    ["7"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont7.png",
    ["8"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont8.png",
    ["9"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont9.png",
    ["."] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFontDecimal.png",
}


sc.Name = "I9SkHxF";
sc.Parent = game:GetService("CoreGui");
pgui(sc);

holder.Name = "UiOl#Sz8G";
holder.Size = UDim2.new(0, 200, 0, 50);
holder.Position = UDim2.new(0.7, 0, 0.8, 0);
holder.BackgroundTransparency = 1;
holder.ZIndex = 123456789;
holder.Parent = sc;

textHolder.Size = UDim2.new(1, 0, 1, 0);
textHolder.BackgroundTransparency = 1;
textHolder.Parent = holder;

for char, url in pairs(url) do
    local fileName = "NFont" .. char .. ".png";
    local imgdata = game:HttpGet(url);
    writefile(fileName, imgdata);
    digitstuff[char] = getcustomasset(fileName);
end;

function renderNumber(num)
    textHolder:ClearAllChildren();
    local str = tostring(num);
    local xOffset = 0;
    for i = 1, #str do
        local char = string.sub(str, i, i);
        local img = digitstuff[char];
        if img then
            local digitLabel = Instance.new("ImageLabel");
            digitLabel.Image = img;
            digitLabel.Size = UDim2.new(0, 50, 0, 50);
            digitLabel.Position = UDim2.new(0, xOffset, 0, 0);
            digitLabel.BackgroundTransparency = 1;
            digitLabel.Parent = textHolder;
            xOffset = xOffset + 20;
        end;
    end;
end;

local lastPos = nil;
local smoothed = 0;

RunService.RenderStepped:Connect(function();
    local char = player.Character;
    local root = char and char:FindFirstChild("HumanoidRootPart");
    if root then
        local currentTime = tick();
        if currentTime - lastUpdate >= tickspeed then;
            local velocity;
            if lastPos then
                local delta = (root.Position - lastPos);
                delta = Vector3.new(delta.X, 0, delta.Z);
                velocity = delta.Magnitude / (currentTime - lastUpdate);
            else
                velocity = 0;
            end;
            smoothed = smoothed + (velocity - smoothed) * 0.2;
            local spsText = string.format("%.1f", smoothed);
            renderNumber(spsText);
            lastPos = root.Position;
            lastUpdate = currentTime;
        end;
    end;
end);

Notify.WaterNotify("MKWIISM", "Finished Loading!", 5);


