require "common.c4_bindings"


function PRX_CMD.LINES_INFO(idBinding, tParams)
	SetLinesInfo(tParams)
end

function EX_CMD.LINES_INFO(tParams)
	SetLinesInfo(tParams)
end

function SetLinesInfo(tParams)
	local dmxLines = {}
	-- Line is an index in the tParams
	for k, v in pairs(tParams) do
		-- This is a line
		if tonumber(k) then
			LogDebug('Line %d %s', tonumber(k), v)
			if v == 'DMX' then table.insert(dmxLines, tonumber(k)) end
		end
	end
	PersistData.Lines = dmxLines
	UpdateGatewayLineVisibility()
end

function LUA_ACTION.Manual_Lock(tParams)
    LockCom_Lock()
end

function LUA_ACTION.ManualUnlock(tParams)
    LockCom_Unlock()
end

function LUA_ACTION.Key_Lock(tParams)
    LockCom_Lock()
end

function LUA_ACTION.Key_Unlock(tParams)
    LockCom_Unlock()
end