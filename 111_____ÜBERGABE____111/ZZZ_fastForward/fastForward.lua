--
-- fastForward
-- 
-- 
--
-- upsideDown 12.07.2013
-- V1.1 conversion to LS15: 1.11.2014
-- V1.3 added minuteChangeEvents guardian

fastForward = {};
addModEventListener(fastForward);
function fastForward.prerequisitesPresent(specializations)
    return true;
end;

function fastForward:loadMap(name)
	
	fastForward.Active = false;
	fastForward.minuteCnt = g_currentMission.environment.currentMinute;
	g_currentMission.environment:addMinuteChangeListener(self)
	g_currentMission.environment:addHourChangeListener(self)
	print("--- fast Forward Mod V2.1 loaded --- (by upsidedown)")
end;

function fastForward:deleteMap()
	
end


function fastForward:mouseEvent(posX, posY, isDown, isUp, button)
end;

function fastForward:keyEvent(unicode, sym, modifier, isDown)
end;


function fastForward:update(dt)
	if g_currentMission:getIsClient() then
		if g_gui.currentGui == nil then
			if g_currentMission:getIsServer() or g_currentMission.isMasterUser then
				if g_currentMission.controlledVehicle == nil then
					g_currentMission:addHelpButtonText(g_i18n:getText("fastForward"), InputBinding.fastForward);
					--if Input.isKeyPressed(Input.KEY_r) and Input.isKeyPressed(Input.KEY_lctrl) then
					if InputBinding.isPressed(InputBinding.fastForward) then
						if not fastForward.Active then
							--local timeScaleIndex = Utils.getTimeScaleIndex(g_currentMission.missionStats.timeScale)
							--fastForward.oldTimeScale = Utils.getTimeScaleFromIndex(timeScaleIndex)
							fastForward.oldTimeScale = g_currentMission.loadingScreen.missionInfo.timeScale;
							fastForward.Active = true;
							g_currentMission:setTimeScale(12000)
							--g_currentMission:getTimeScale()
						end
					else
						if fastForward.Active then
							fastForward.Active = false;
							g_currentMission:setTimeScale(fastForward.oldTimeScale)
							--g_currentMission:setTimeScale(1)
						end
					end;	
				end;	
			end;
		end;
	end
end

function fastForward:minuteChanged()
	fastForward.minuteCnt = fastForward.minuteCnt +1;
end;


function fastForward:hourChanged()
	if fastForward.minuteCnt < 60 then
		for k = 1,60-fastForward.minuteCnt,1 do
			for _, listener in pairs(g_currentMission.environment.minuteChangeListeners) do
			  listener:minuteChanged()
			  --print("listener ",tostring(listener))
			end
			--print("minute "..tostring(k))			
		end;	
	end;

	--print(fastForward.minuteCnt)
	fastForward.minuteCnt = 0;
end;





function fastForward:draw()
   
   
end;
