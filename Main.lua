local mt = getrawmetatable(game)
setreadonly(mt, false)

local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if getnamecallmethod() == "FireServer" then
        if tostring(self):lower():find("dialogue") or tostring(self):lower():find("choice") then
            warn("🗨️ Dialogue Remote Triggered:", self:GetFullName())
            for i,v in ipairs(args) do
                warn("Arg " .. i .. ":", typeof(v), v)
            end
        end
    end
    return old(self, unpack(args))
end)
