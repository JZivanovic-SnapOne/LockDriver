--[[=============================================================================
    File is: lock_communicator.lua

    Copyright 2018 Control4 Corporation. All Rights Reserved.
===============================================================================]]

if (TEMPLATE_VERSION ~= nil) then
	TEMPLATE_VERSION.lock_communicator = "2018.08.16"
end

function LockCom_Lock(Source,Description)
	LogTrace("LockCom_Lock")
	print(Source)
	if Source == nil then
		Source = "Customer"
	end
	if Description == nil then
		Description = Properties["Action Description"]
	end
	LockReport_LockStatus(LS_LOCKED,Description,Source,false)
	print(IsLocked())
	if IsLocked() == true then
    	UpdateProperty("Lock Status", "Locked")
	elseif IsLocked() == false then
    	UpdateProperty("Lock Status", "Unlocked")
	end

end

function LockCom_Unlock(Source,Description)
	LogTrace("LockCom_Unlock")
	print(Source)
	if Source == nil then
		Source = "Customer"
	end
	if Description == nil then
		Description = Properties["Action Description"]
	end
	LockReport_LockStatus(LS_UNLOCKED,Description,Source,false)
	print(IsLocked())
	if IsLocked() == true then
    	UpdateProperty("Lock Status", "Locked")
	elseif IsLocked() == false then
    	UpdateProperty("Lock Status", "Unlocked")
	end

end


function LockCom_VerifySettings()
	LogTrace("LockCom_VerifySettings")
	if IsLocked() == true then
    	UpdateProperty("Lock Status", "Locked")
	elseif IsLocked() == false then
    	UpdateProperty("Lock Status", "Unlocked")
	end

end


-- function LockCom_SetAdminCode(AdminCode)
	-- LogTrace("LockCom_SetAdminCode")
	-- LogDev("Code: %s", tostring(AdminCode))

-- end


function LockCom_VerifyAdminCode()
	LogTrace("LockCom_VerifyAdminCode")

end


function LockCom_SetScheduleLockoutEnabled(ScheduleLockoutFlag)
	NOTIFY.SETTING_CHANGED("schedule_lockout_enabled",ScheduleLockoutFlag,LOCK_PROXY_BINDINGID)
	LockReport_UpdateCurrentSetting("schedule_lockout_enabled", ScheduleLockoutFlag)
	LogTrace("LockCom_SetScheduleLockoutEnabled Set flag to: %s", tostring(ScheduleLockoutFlag))

end


function LockCom_SetNumberLogItems(LogItemsCount)
	NOTIFY.SETTING_CHANGED("log_item_count",LogItemsCount,LOCK_PROXY_BINDINGID)
	LockReport_UpdateCurrentSetting("log_item_count", LogItemsCount)
	LogTrace("LockCom_SetNumberLogItems Count: %d", LogItemsCount)

end


function LockCom_SetAutoLockSeconds(AutoLockSeconds)
	NOTIFY.SETTING_CHANGED("auto_lock_time",AutoLockSeconds,LOCK_PROXY_BINDINGID)
	LockReport_UpdateCurrentSetting("auto_lock_time", AutoLockSeconds)
	LogTrace("LockCom_SetAutoLockSeconds Seconds: %d", AutoLockSeconds)

end


function LockCom_SetLockMode(NewLockMode)
	NOTIFY.SETTING_CHANGED("lock_mode",NewLockMode,LOCK_PROXY_BINDINGID)
	LockReport_UpdateCurrentSetting("lock_mode", NewLockMode)
	LogTrace("LockCom_SetLockMode Mode: %s", tostring(NewLockMode))

end


function LockCom_SetLogFailedAttempts(LogAttempts)
	NOTIFY.SETTING_CHANGED("log_failed_attempts",LogAttempts,LOCK_PROXY_BINDINGID)
	LockReport_UpdateCurrentSetting("log_failed_attempts", LogAttempts)
	LogTrace("LockCom_SetLogFailedAttempts Flag: %s", tostring(LogAttempts))

end


function LockCom_SetWrongCodeAttempts(WrongAttempts)
	NOTIFY.SETTING_CHANGED("wrong_code_attempts",WrongAttempts,LOCK_PROXY_BINDINGID)
	LockReport_UpdateCurrentSetting("wrong_code_attempts", WrongAttempts)
	LogTrace("LockCom_SetWrongCodeAttempts WrongAttempts: %d", WrongAttempts)

end


function LockCom_SetShutoutTimer(ShutoutTimeSeconds)
	NOTIFY.SETTING_CHANGED("shutout_timer",ShutoutTimeSeconds,LOCK_PROXY_BINDINGID)
	LockReport_UpdateCurrentSetting("shutout_timer", ShutoutTimeSeconds)
	LogTrace("LockCom_SetShutoutTimer ShutoutTimeSeconds: %d", ShutoutTimeSeconds)

end


function LockCom_SetLanguage(TargetLanguage)
	NOTIFY.SETTING_CHANGED("language",TargetLanguage,LOCK_PROXY_BINDINGID)
	LockReport_UpdateCurrentSetting("language", TargetLanguage)
	LogTrace("LockCom_SetLanguage TargetLanguage: %s", tostring(TargetLanguage))

end


function LockCom_SetVolume(TargetVolume)
	NOTIFY.SETTING_CHANGED("volume",TargetVolume,LOCK_PROXY_BINDINGID)
	LockReport_UpdateCurrentSetting("volume", TargetVolume)
	LogTrace("LockCom_SetVolume TargetVolume: %s", tostring(TargetVolume))

end

userID = 0
users__ = {}
function LockCom_AddUser(UserName, PassCode, ActiveFlag, RestrictedScheduleFlag, ScheduleType,
                          StartDateYear, StartDateMonth, StartDateDay, EndDateYear, EndDateMonth, EndDateDay,
						  StartTime, EndTime,
						  OnSunday, OnMonday, OnTuesday, OnWednesday, OnThursday, OnFriday, OnSaturday
						 )
	LogTrace("LockCom_AddUser: %s", tostring(UserName))
	userID = userID + 1
	maxUsers = GetMaxUsers()
	
	LockReport_AddUser(userID)

	LockReport_UserName(userID, UserName)
	LockReport_UserPassCode(userID, PassCode)

	if RestrictedScheduleFlag == true then 
		LockReport_UserActiveFlag(userID,ActiveFlag)
		LockReport_UserRestrictedScheduleFlag(userID, RestrictedScheduleFlag)
		LockReport_UserScheduleType(userID, ScheduleType)
		if ScheduleType == "date_range" then
			LockReport_UserDateRange(userID, StartDateYear, StartDateMonth, StartDateDay, EndDateYear, EndDateMonth, EndDateDay)
		elseif ScheduleType == "daily" then
			LockReport_UserScheduleDays(userID, OnSunday, OnMonday, OnTuesday, OnWednesday, OnThursday, OnFriday, OnSaturday)
		end
		LockReport_UserRestrictedTime(userID, StartTime, EndTime)
	end

	IsUserValid(userID)

	users__[userID] = {UserName=UserName, PassCode=PassCode, ActiveFlag=ActiveFlag, RestrictedScheduleFlag=RestrictedScheduleFlag, ScheduleType=ScheduleType,
	StartDateYear=StartDateYear, StartDateMonth=StartDateMonth, StartDateDay=StartDateDay, EndDateYear=EndDateYear, EndDateMonth=EndDateMonth, EndDateDay=EndDateDay,
	StartTime=StartTime, EndTime=EndTime,
	OnSunday=OnSunday, OnMonday=OnMonday, OnTuesday=OnTuesday, OnWednesday=OnWednesday, OnThursday=OnThursday, OnFriday=OnFriday, OnSaturday=OnSaturday}

	C4:PersistSetValue("_users_",users__)

	NOTIFY.USER_ADDED(userID,UserName, PassCode, 
	ActiveFlag, true,
	StartDateDay, StartDateMonth, StartDateYear,
	EndDateDay, EndDateMonth, EndDateYear,
	StartTime, EndTime,
	ScheduleType, RestrictedScheduleFlag,
	5001)
end


function LockCom_SetOneTouchLocking(AllowOneTouchLocking)
	NOTIFY.SETTING_CHANGED("one_touch_locking",AllowOneTouchLocking,LOCK_PROXY_BINDINGID)
	LockReport_UpdateCurrentSetting("one_touch_locking", AllowOneTouchLocking)
	LogTrace("LockCom_SetOneTouchLocking AllowOneTouchLocking: %s", tostring(AllowOneTouchLocking))

end


function LockCom_SetCustomSetting(SettingName, SettingValue)
	LogTrace("LockCom_SetCustomSetting  Set %s to %s", tostring(SettingName), tostring(SettingValue))

end


function LockCom_VerifyUsers()
	LogTrace("LockCom_VerifyUsers")

end


function LockCom_EditUser(UserID, UserName, PassCode, ActiveFlag, RestrictedScheduleFlag, ScheduleType,
                          StartDateYear, StartDateMonth, StartDateDay, EndDateYear, EndDateMonth, EndDateDay,
						  StartTime, EndTime,
						  OnSunday, OnMonday, OnTuesday, OnWednesday, OnThursday, OnFriday, OnSaturday
						 )
	LogTrace("LockCom_EditUser: %d", UserID)
	LockReport_UpdateUserInformation(UserID, UserName, PassCode,
											ActiveFlag, RestrictedScheduleFlag, ScheduleType,
											StartTime, EndTime,
											StartDateYear, StartDateMonth, StartDateDay,
											EndDateYear, EndDateMonth, EndDateDay,
											OnSunday, OnMonday, OnTuesday, OnWednesday,
											OnThursday, OnFriday, OnSaturday
										 )
	users__[UserID] = {UserName=UserName, PassCode=PassCode, ActiveFlag=ActiveFlag, RestrictedScheduleFlag=RestrictedScheduleFlag, ScheduleType=ScheduleType,
	StartDateYear=StartDateYear, StartDateMonth=StartDateMonth, StartDateDay=StartDateDay, EndDateYear=EndDateYear, EndDateMonth=EndDateMonth, EndDateDay=EndDateDay,
	StartTime=StartTime, EndTime=EndTime,
	OnSunday=OnSunday, OnMonday=OnMonday, OnTuesday=OnTuesday, OnWednesday=OnWednesday, OnThursday=OnThursday, OnFriday=OnFriday, OnSaturday=OnSaturday}

	C4:PersistSetValue("_users_",users__)

end


function LockCom_DeleteUser(UserID)
	LogTrace("LockCom_DeleteUser: %d", UserID)
	LockReport_DeleteUser(UserID)
	users__[UserID] = nil
	C4:PersistSetValue("_users_",users__)

end


function LockCom_AddCustomSetting(CustomSettingName, CustomSettingValue)
	LogTrace("LockCom_AddCustomSetting: %s", tostring(CustomSettingName))

end


function LockCom_UpdateCustomSetting(CustomSettingName, CustomSettingValue)
	LogTrace("LockCom_UpdateCustomSetting: %s -> %s", tostring(CustomSettingName), tostring(CustomSettingValue))

end


function LockCom_DeleteCustomSetting(CustomSettingName)
	LogTrace("LockCom_DeleteCustomSetting: %s", tostring(CustomSettingName))

end

