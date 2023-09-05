require "lib.c4_queue"

require "common.c4_driver_declarations"
require "common.c4_common"
require "common.c4_property"
require "common.c4_init"
require "common.c4_command"
require "common.c4_diagnostics"
require "common.c4_notify"
require "common.c4_utils"

require "lock_proxy.lock_main"
--require "lock_proxy.lock_proxy_commands"
--require "lock_proxy.lock_proxy_notifies"
require "lock_proxy.lock_reports"

require "proxy_commands"
require "lock_communicator"


LOCK_PROXY_BINDINGID = DEFAULT_PROXY_BINDINGID


function isTableEmpty(t)
	if(type(t) ~= 'table') then return nil end
	if(next(t)==nil) then return true end
	return false
end


function ON_DRIVER_LATEINIT.Init()
	CreateLockProxy(LOCK_PROXY_BINDINGID,"Lock Proxy")
	LockReport_InitialLockStatus(false)
	if IsLocked() == true then
    	UpdateProperty("Lock Status", "Locked")
	elseif IsLocked() == false then
    	UpdateProperty("Lock Status", "Unlocked")
	end
	--local users_
	--users_ = C4:PersistGetValue('users') or ''
	--print(users_)
end

--[[function ReceivedFromProxy(idBinding, sCommand, tParams)
    print("Received from proxy")
	
    print(sCommand)
end]]