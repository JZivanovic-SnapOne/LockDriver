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
    LockCom_Lock("Driver","Manual Lock")
end

function LUA_ACTION.Manual_Unlock(tParams)
    LockCom_Unlock("Driver", "Manual Unlock")
end

function LUA_ACTION.Key_Lock(tParams)
    LockCom_Lock("Driver", "Key Lock")
end

function LUA_ACTION.Key_Unlock(tParams)
    LockCom_Unlock("Driver", "Key Unlock")
end

function LUA_ACTION.Print_User(tParams)
	--PRX_CMD.REQUEST_USERS(5001, tParams)
	local users_ = C4:PersistGetValue('_users_') or ''
	for k, v in pairs(users_) do
		if k > userID then 
			break
		end
		for k1, v1 in pairs(v) do
			if k1 == "StartTime" or k1 == "EndTime" then
				print(k1,("%02d:%02d"):format(math.floor(v1/60),v1%60))
			else
				print(k1, v1)
			end
		end
		print("---------------------------")
	end
end

function LUA_ACTION.Fault_state(tParams)
	LockReport_LockStatus(LS_FAULT,"Fault","Driver",false)
end