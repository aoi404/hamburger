-- Grow a Garden Info Gatherer Script

local function printTable(tbl, indent)
    indent = indent or 0
    local prefix = string.rep("  ", indent)
    for k, v in pairs(tbl) do
        if typeof(v) == "Instance" then
            print(prefix .. tostring(k) .. ": " .. v.ClassName .. " (" .. v.Name .. ")")
        elseif type(v) == "table" then
            print(prefix .. tostring(k) .. ": table")
            printTable(v, indent + 1)
        else
            print(prefix .. tostring(k) .. ": " .. tostring(v))
        end
    end
end

print("=== Workspace Children ===")
printTable(workspace:GetChildren())

print("=== ReplicatedStorage Children ===")
local rs = game:GetService("ReplicatedStorage")
printTable(rs:GetChildren())

print("=== Remotes in ReplicatedStorage ===")
for _, v in pairs(rs:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        print("Remote: " .. v:GetFullName())
    end
end

print("=== Remotes in Workspace ===")
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        print("Remote: " .. v:GetFullName())
    end
end

-- Hook remote events to log arguments when fired
local function hookRemotes(container)
    for _, v in pairs(container:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            v.OnClientEvent:Connect(function(...)
                print("[RemoteEvent] " .. v:GetFullName() .. " fired with args:")
                printTable({...})
            end)
        elseif v:IsA("RemoteFunction") then
            local oldInvoke = v.OnClientInvoke
            v.OnClientInvoke = function(...)
                print("[RemoteFunction] " .. v:GetFullName() .. " invoked with args:")
                printTable({...})
                if oldInvoke then
                    return oldInvoke(...)
                end
            end
        end
    end
end

hookRemotes(rs)
hookRemotes(workspace)

print("=== Info Gatherer Loaded ===")
