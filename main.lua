---@shape Status
---@field enabled boolean

---@type table<string, Status>
THCT_chatToStatus = THCT_chatToStatus or {}

---@param chatFrame Frame
---@return boolean
local function getHardcoreEnabled(chatFrame)
    local name = chatFrame:GetName()
    if THCT_chatToStatus[name] == nil then
        return true -- add to Hardcore chat by default
    end
    return THCT_chatToStatus[name]["enabled"]
end

---@param chatFrame Frame
---@param enabled boolean
local function setHardcoreEnabled(chatFrame, enabled)
    THCT_chatToStatus[chatFrame:GetName()] = { ["enabled"] = enabled }
end

local HARDCORE_GROUP = "HARDCORE"

local Hook_ChatFrame_RegisterForMessages = ChatFrame_RegisterForMessages
function ChatFrame_RegisterForMessages(...)
    Hook_ChatFrame_RegisterForMessages(unpack(arg))

    if not getHardcoreEnabled(this) then
        ChatFrame_RemoveMessageGroup(this, HARDCORE_GROUP)
    end
end

local Hook_ChatFrame_AddMessageGroup = ChatFrame_AddMessageGroup
function ChatFrame_AddMessageGroup(chatFrame, group)
    Hook_ChatFrame_AddMessageGroup(chatFrame, group)

    if group == HARDCORE_GROUP then
        setHardcoreEnabled(chatFrame, true)
    end
end

local Hook_ChatFrame_RemoveMessageGroup = ChatFrame_RemoveMessageGroup
function ChatFrame_RemoveMessageGroup(chatFrame, group)
    Hook_ChatFrame_RemoveMessageGroup(chatFrame, group)

    if group == HARDCORE_GROUP then
        setHardcoreEnabled(chatFrame, false)
    end
end
