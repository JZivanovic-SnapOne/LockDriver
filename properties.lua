BATTERY_LEVEL = "Battery Level"
HAS_ADMIN_CODE = "Has admin code"
IS_MANAGEMENT_ONLY = "Is management only"
HAS_SCHEDULE_LOCKOUT = "Has schedule lockout"
HAS_LOG_ITEM_COUNT = "Has log item count"
HAS_LOCK_MODES = "Has lock modes"
HAS_LOG_FAILED_ATTEMPTS = "Has log failed attempts"
HAS_WRONG_CODE_ATTEMPTS = "Has wrong code attempts"

ON_PROPERTY_CHANGED[BATTERY_LEVEL] = function(params)
	if params == "Normal" then
		BParams = LBS_NORMAL
	elseif params == "Warning" then
		BParams = LBS_WARNING
	elseif params == "Critical" then
		BParams = LBS_CRITICAL
	end
	LockReport_BatteryStatus(BParams)
end

ON_PROPERTY_CHANGED[HAS_ADMIN_CODE] = function(params)
	NOTIFY.CAPABILITY_CHANGED(CAP_HAS_ADMIN_CODE, params, LOCK_PROXY_BINDINGID)
	LockReport_CapabilityChanged(CAP_HAS_ADMIN_CODE, params)
end

ON_PROPERTY_CHANGED[IS_MANAGEMENT_ONLY] = function(params)
	NOTIFY.CAPABILITY_CHANGED(CAP_IS_MANAGEMENT_ONLY, params, LOCK_PROXY_BINDINGID)
	LockReport_CapabilityChanged(CAP_IS_MANAGEMENT_ONLY, params)
end

ON_PROPERTY_CHANGED[HAS_SCHEDULE_LOCKOUT] = function(params)
	NOTIFY.CAPABILITY_CHANGED(CAP_HAS_SCHEDULE_LOCKOUT, params, LOCK_PROXY_BINDINGID)
	LockReport_CapabilityChanged(CAP_HAS_SCHEDULE_LOCKOUT, params)
end

ON_PROPERTY_CHANGED[HAS_LOG_ITEM_COUNT] = function(params)
	NOTIFY.CAPABILITY_CHANGED(CAP_HAS_LOG_ITEM_COUNT, params, LOCK_PROXY_BINDINGID)
	LockReport_CapabilityChanged(CAP_HAS_LOG_ITEM_COUNT, params)
end

ON_PROPERTY_CHANGED[HAS_LOCK_MODES] = function(params)
	NOTIFY.CAPABILITY_CHANGED(CAP_HAS_LOCK_MODES, params, LOCK_PROXY_BINDINGID)
	LockReport_CapabilityChanged(CAP_HAS_LOCK_MODES, params)
end

ON_PROPERTY_CHANGED[HAS_LOG_FAILED_ATTEMPTS] = function(params)
	NOTIFY.CAPABILITY_CHANGED(CAP_HAS_LOG_FAILED_ATTEMPTS, params, LOCK_PROXY_BINDINGID)
	LockReport_CapabilityChanged(CAP_HAS_LOG_FAILED_ATTEMPTS, params)
end

ON_PROPERTY_CHANGED[HAS_WRONG_CODE_ATTEMPTS] = function(params)
	NOTIFY.CAPABILITY_CHANGED(CAP_HAS_WRONG_CODE_ATTEMPTS, params, LOCK_PROXY_BINDINGID)
	LockReport_CapabilityChanged(CAP_HAS_WRONG_CODE_ATTEMPTS, params)
end
