--[[=============================================================================
    File is: lock_communicator.lua

    Copyright 2018 Control4 Corporation. All Rights Reserved.
===============================================================================]]

if (TEMPLATE_VERSION ~= nil) then
	TEMPLATE_VERSION.lock_communicator = "2018.08.16"
end

function LockCom_Lock()
	LogTrace("LockCom_Lock")
	LockReport_LockStatus(LS_LOCKED,"Locked","aa",false)
	print(IsLocked())
	if IsLocked() == true then
    	UpdateProperty("Lock Status", "Locked")
	elseif IsLocked() == false then
    	UpdateProperty("Lock Status", "Unlocked")
	end

end

function LockCom_Unlock()
	LogTrace("LockCom_Unlock")
	LockReport_LockStatus(LS_UNLOCKED,"Locked","aa",false)
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
	LogTrace("LockCom_SetScheduleLockoutEnabled Set flag to: %s", tostring(ScheduleLockoutFlag))

end


function LockCom_SetNumberLogItems(LogItemsCount)
	LogTrace("LockCom_SetNumberLogItems Count: %d", LogItemsCount)

end


function LockCom_SetAutoLockSeconds(AutoLockSeconds)
	LogTrace("LockCom_SetAutoLockSeconds Seconds: %d", AutoLockSeconds)

end


function LockCom_SetLockMode(NewLockMode)
	LogTrace("LockCom_SetLockMode Mode: %s", tostring(NewLockMode))

end


function LockCom_SetLogFailedAttempts(LogAttempts)
	LogTrace("LockCom_SetLogFailedAttempts Flag: %s", tostring(LogAttempts))

end


function LockCom_SetWrongCodeAttempts(WrongAttempts)
	LogTrace("LockCom_SetWrongCodeAttempts WrongAttempts: %d", WrongAttempts)

end


function LockCom_SetShutoutTimer(ShutoutTimeSeconds)
	LogTrace("LockCom_SetShutoutTimer ShutoutTimeSeconds: %d", ShutoutTimeSeconds)

end


function LockCom_SetLanguage(TargetLanguage)
	LogTrace("LockCom_SetLanguage TargetLanguage: %s", tostring(TargetLanguage))

end


function LockCom_SetVolume(TargetVolume)
	LogTrace("LockCom_SetVolume TargetVolume: %s", tostring(TargetVolume))

end

userID = 0
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
		--data_range
		if ScheduleType == "date_range" then
			--print ("Start yy/mm/dd ".. tostring(StartDateYear).."/"..tostring(StartDateMonth).."/"..tostring(StartDateDay))
			--print ("Start yy/mm/dd ".. tostring(EndDateYear).."/"..tostring(EndDateMonth).."/"..tostring(EndDateDay))
			LockReport_UserDateRange(userID, StartDateYear, StartDateMonth, StartDateDay, EndDateYear, EndDateMonth, EndDateDay)
		elseif ScheduleType == "daily" then
			--print ("Schedule Type daily")
			LockReport_UserScheduleDays(userID, OnSunday, OnMonday, OnTuesday, OnWednesday, OnThursday, OnFriday, OnSaturday)
		end
		-- daily, verovatno
		LockReport_UserRestrictedTime(userID, StartTime, EndTime)
	end

	IsUserValid(userID)
	
	NOTIFY.USER_ADDED(userID,UserName, PassCode, 
	ActiveFlag, true,
	StartDateDay, StartDateMonth, StartDateYear,
	EndDateDay, EndDateMonth, EndDateYear,
	StartTime, EndTime,
	ScheduleType, RestrictedScheduleFlag,
	5001)
end


function LockCom_SetOneTouchLocking(AllowOneTouchLocking)
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

end


function LockCom_DeleteUser(UserID)
	LogTrace("LockCom_DeleteUser: %d", UserID)
	LockReport_DeleteUser(UserID)

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

