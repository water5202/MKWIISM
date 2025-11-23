-- c o d i n g  i s  a d d i c t i v e
local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/water5202/Notification-Library/refs/heads/main/Notify.lua"))();
Notify.WaterNotify("MKWIISM", "Loading...", 5);

repeat wait() until game:IsLoaded();

local PROTECT_GUI = protectgui or (syn and syn.protect_gui) or (function() end)
local PLAYER = game.Players.LocalPlayer
local SCREEN_GUI = Instance.new("ScreenGui")
local RUN_SERVICE = game:GetService("RunService")
local TICK_SPEED = 0.05
local LAST_UPDATE = 0
local HOLDER_FRAME = Instance.new("Frame")
local TEXT_HOLDER = Instance.new("Frame")
local DIGIT_ASSETS = {}

local DIGIT_URLS = {
    ["0"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont0.png",
    ["1"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont1.png",
    ["2"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont2.png",
    ["3"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont3.png",
    ["4"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont4.png",
    ["5"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont5.png",
    ["6"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont6.png",
    ["7"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont7.png",
    ["8"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont8.png",
    ["9"] = "https://raw.githubusercontent.com/water5202/MKWII-SpeedMeter/refs/heads/main/NFont/NFont9.png"
}

SCREEN_GUI.Name = "I9SkHxF"
SCREEN_GUI.Parent = game:GetService("CoreGui")
PROTECT_GUI(SCREEN_GUI)

HOLDER_FRAME.Name = "UiOl#Sz8G"
HOLDER_FRAME.Size = UDim2.new(0, 200, 0, 50)
HOLDER_FRAME.Position = UDim2.new(0.7, 0, 0.8, 0)
HOLDER_FRAME.BackgroundTransparency = 1
HOLDER_FRAME.ZIndex = 123456789
HOLDER_FRAME.Parent = SCREEN_GUI

TEXT_HOLDER.Size = UDim2.new(1, 0, 1, 0)
TEXT_HOLDER.BackgroundTransparency = 1
TEXT_HOLDER.Parent = HOLDER_FRAME

for CHAR, URL in pairs(DIGIT_URLS) do
    local FILE_NAME = "NFont" .. CHAR .. ".png"
    local IMG_DATA = game:HttpGet(URL)
    writefile(FILE_NAME, IMG_DATA)
    DIGIT_ASSETS[CHAR] = getcustomasset(FILE_NAME)
end

local LAST_POS = nil
local SMOOTHED_SPEED = 0

local function render_number(NUM)
    task.wait()
    TEXT_HOLDER:ClearAllChildren()
    local STR = tostring(NUM)
    local X_OFFSET = 0
    for i = 1, #STR do
        local CHAR = string.sub(STR, i, i)
        local IMG = DIGIT_ASSETS[CHAR]
        if IMG then
            local DIGIT_LABEL = Instance.new("ImageLabel")
            DIGIT_LABEL.Image = IMG
            DIGIT_LABEL.Size = UDim2.new(0, 50, 0, 50)
            DIGIT_LABEL.Position = UDim2.new(0, X_OFFSET, 0, 0)
            DIGIT_LABEL.BackgroundTransparency = 1
            DIGIT_LABEL.Parent = TEXT_HOLDER
            X_OFFSET = X_OFFSET + 20
        end
    end
end

RUN_SERVICE.RenderStepped:Connect(function()
    local CHAR = PLAYER.Character
    local ROOT = CHAR and CHAR:FindFirstChild("HumanoidRootPart")
    if ROOT then
        local CURRENT_TIME = tick()
        if CURRENT_TIME - LAST_UPDATE >= TICK_SPEED then
            local VELOCITY
            if LAST_POS then
                local DELTA = (ROOT.Position - LAST_POS)
                DELTA = Vector3.new(DELTA.X, 0, DELTA.Z)
                VELOCITY = DELTA.Magnitude / (CURRENT_TIME - LAST_UPDATE)
            else
                VELOCITY = 0
            end
            SMOOTHED_SPEED = SMOOTHED_SPEED + (VELOCITY - SMOOTHED_SPEED)
            local SPS_TEXT = tostring(math.floor(SMOOTHED_SPEED))
            render_number(SPS_TEXT)
            LAST_POS = ROOT.Position
            LAST_UPDATE = CURRENT_TIME
        end
    end
end)

Notify.WaterNotify("MKWIISM", "Finished Loading!", 5)
