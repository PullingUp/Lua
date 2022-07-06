local debuginfo = {infCount = 0}
setfpscap(60)


function debuginfo:new()
    local guif = {}
    local gui = Instance.new("ScreenGui")
    if syn then
        syn.protect_gui(gui)
    end
    gui.Parent = game.CoreGui.RobloxGui
    gui.Name = math.random(10000, 99999)
    gui.ResetOnSpawn = false

    function guif:newInfo(text)
        local frame = {}

        local text = text or ""

        local nText = Instance.new("TextLabel", gui)
        nText.BackgroundColor3 = Color3.fromRGB(0,0,0)
        nText.Size = UDim2.new(0, 190, 0, 22)
        nText.Position = UDim2.new(0, 0, 0, 300 + (debuginfo.infCount * 14))
        nText.Font = Enum.Font.SourceSans
        nText.TextSize = 14
        nText.TextXAlignment = Enum.TextXAlignment.Right
        nText.TextColor3 = Color3.fromRGB(255,255,255)
        nText.BorderSizePixel = 0

        function frame:updateText(newText)
            text = newText
        end

        spawn(function()
            game:GetService('RunService').RenderStepped:Connect(function()
                nText.Text = text
                nText.Size = UDim2.new(0, 10000, 0, 10000)
                nText.Size = UDim2.new(0, nText.TextBounds.X + 10, 0, nText.TextBounds.Y)
            end)
        end)

        debuginfo.infCount = debuginfo.infCount + 1

        return frame
    end

    return guif
end

local Config = {Strength = 3000, Amount = 0}

local APITarpit = debuginfo:new()
local Title = APITarpit:newInfo("// MTL Tarpit Stats \\\\")
local Strength = APITarpit:newInfo("KeepAliveRate: " .. Config.Strength)
local SEPLatency = APITarpit:newInfo("X->S SRVCheck: " .. 34832234 .. " : 3842")
local TimeBefore = os.clock()
local Resp = game.ReplicatedStorage.DefaultChatSystemChatEvents.GetInitDataRequest:InvokeServer()
repeat game:GetService('RunService').RenderStepped:Wait() until Resp
local EPSLatency = APITarpit:newInfo("EP->S Latency *LATEST_INCOMING_REQUEST: " .. os.clock()-TimeBefore .. "ms")
local SX = APITarpit:newInfo("EP->S Latency *SPCLAT: " .. math.random() .. "s")

game:GetService('RunService').RenderStepped:Connect(function()
    for i = 1, Config.Strength do
        game:GetService("LogService"):RequestServerHttpResult() -- actual code that makes it work!
        game:GetService("LogService"):RequestServerOutput() -- actual code that makes it work!
    end
end)

while wait(.05) do
   SX:updateText("EP->S Latency *SPCLAT: " .. math.random() .. "s IT->R *SPCLAT: "..math.random(1,30).."."..math.random())
   EPSLatency:updateText("LS->S Clock *SERVER_TIME_CLOCK_DIF: " .. workspace:GetServerTimeNow()-os.time()  .. 's')
end
