local vars={['funcs']={}}
vars.maus=funcs.lplr:GetMouse()
vars.tws=game:GetService("TweenService")
vars.funcs.getroot=function(model)
	local pr=model:FindFirstChildWhichIsA('BasePart')
	pr=pr and pr.AssemblyRootPart
	return pr
end
vars.funcs.cdtp=function(kk)
	if kk.UserInputType == Enum.UserInputType.MouseButton3 and funcs.uip:IsKeyDown(Enum.KeyCode.K) then
		if vars.pivotm then getchar():PivotTo(vars.maus.Hit*CFrame.new(0,2.45,0)) else local root=vars.funcs.getroot(getchar()) if root then root.CFrame=vars.maus.Hit root=nil end end
	end
end
vars.funcs.ctp=function(ch,goal,speed) --creepteleport.iy improved
if not goal then return end
						local hmnoid=funcs.wfcofclass(ch,'Humanoid',20)
                        local view = Instance.new("Part")
                        view.Transparency = 1 view.CanCollide = false view.Anchored = true view.CFrame = goal * CFrame.new(hmnoid.CameraOffset) view.Parent = workspace workspace.CurrentCamera.CameraSubject = view
                        if hmnoid and hmnoid.SeatPart then
                            hmnoid.Sit = false
                            funcs.runs.Stepped:Wait()
                        end
                        local HRP = hmnoid.RootPart or hmnoid:GetPropertyChangedSignal'RootPart':Wait()
                        HRP.Anchored = true
                        HRP.CFrame = goal * CFrame.new(0, -24, 0)
                        local tween = vars.tws:Create(HRP, TweenInfo.new(speed and tonumber(speed) or 1), {['CFrame'] = goal})
                        tween:Play()
                        tween.Completed:Connect(function()
                            workspace.CurrentCamera.CameraSubject = hmnoid
                            funcs.deb:AddItem(view,0)
                            if HRP then HRP.Anchored = false end
							funcs.deb:AddItem(tween,0)
							tween,view,HRP=nil,nil,nil
                        end)
end
vars.funcs.togo=function(strt,strd,str)
	local thp=strd and funcs.xgetplr(strd,true)
	if thp and thp.Character then
	
	if vars.pivotm then
	getchar():PivotTo(thp.Character:GetPivot()*CFrame.new(0,0,strt[1] or 0))
	else
	local pr,thumper=vars.funcs.getroot(getchar()),vars.funcs.getroot(thp.Character)
	if pr and thumper then pr.CFrame=thumper.CFrame*CFrame.new(0,0,strt[1] or 0) end
	end
	
	end
end

vars.cdtp=funcs.uip.InputBegan:Connect(vars.funcs.cdtp)
local plug={
["goto"]={['func']=vars.funcs.togo,desc="goto plr (arg[1])",['aliases']={['to']="goto"}};
["boto"]={['func']=function(strt,strd,str) 
local oldpiv=getchar():GetPivot()
str=strt[1] and tonumber(strt[1]) or 1
for i = 1,str do
vars.funcs.togo(strt,strd,str)
task.wait(strt[2] and tonumber(strt[2]) or .05)
getchar():PivotTo(oldpiv)
end
end,['desc']="goto arg[1] plr and back arg[2] amount of times for arg[3] each"};
['pivotm']={['func']=function() vars.pivotm=not vars.pivotm funcs.sendnotif('TPVandalism\\pivotm',tostring(vars.pivotm),'rbxassetid://5562330088',6) end;['desc']='toggle using pivotto instead of .cframe, fixes most tp glitches'};
["lgoto"]={['func']=function(strt,strd,str)
	local thp=strd and funcs.xgetplr(strd,true)
	if not strd then vars.lgoto=nil return end
	local cfd=CFrame.new(0,0,strt[1] or 0)
	vars.lgoto=true
	while vars.lgoto and thp and thp.Character do
	getchar():PivotTo(thp.Character:GetPivot()*cfd)
	task.wait()
	end
	vars.lgoto=nil cfd=nil
end,['desc']="loopgoto [plr dist_away], no arg to cancel"};
["tovoid"]={["func"]=function() vars.outvoid=vars.outvoid or getchar():GetPivot() ; while vars.outvoid do getchar():PivotTo(CFrame.new(Random.new():NextNumber(9e4,9e9),Random.new():NextNumber(9e4,9e9),Random.new():NextNumber(9e4,9e9))) end end;["desc"]="looptp yourself to void"};
["outvoid"]={["func"]=function() if vars.outvoid then  local prr=funcs.wfcofclass(getchar(),'Humanoid',30).RootPart or funcs.wfcofclass(getchar(),'Humanoid'):GetPropertyChangedSignal('RootPart') ; if prr then prr.Anchored=false end getchar():PivotTo(vars.outvoid) vars.outvoid=nil end end;["desc"]="tp where you were before tping to void, unanchors your root too"};
["b"]={["func"]=function(strt,nn,str,cmd,arg) nn=tonumber(nn) or 1.5 cmd=getchar() for i = 1,30 do if not funcs.lplr.Character==cmd then break end local piv=cmd:GetPivot() cmd:PivotTo(piv + (-piv.LookVector * nn/4)) ; piv=cmd:GetPivot() cmd:PivotTo(piv + (-piv.LookVector * nn/4)) task.wait(0) end end;["desc"]="tp backwards arg[1] or 6"};
["f"]={["func"]=function(strt,nn,str,cmd,arg) nn=tonumber(nn) or 1.5 cmd=getchar() for i = 1,30 do if not funcs.lplr.Character==cmd then break end local piv=cmd:GetPivot() cmd:PivotTo(piv + (piv.LookVector * nn/4)) ; piv=cmd:GetPivot() cmd:PivotTo(piv + (piv.LookVector * nn/4))  task.wait(0) end end;["desc"]="tp forwards arg[1] or 6"};
["cdtp"]={['func']=function(strt,plrarg) if vars.cdtp then vars.cdtp:Disconnect() vars.cdtp=nil else vars.cdtp=funcs.uip.InputBegan:Connect(vars.funcs.cdtp) end if plrarg~="nn" then funcs.sendnotif("cmds/toolthing/bambi.exe",vars.cdtp and "hi" or "fucking idiot","rbxassetid://8119590978",4) end end,['desc']="toggle click tp (k+middleclick)"};
["ctp"]={['func']=function(strd,plrarg) plrarg=plrarg and funcs.xgetplr(plrarg,true) plrarg=plrarg and getchar(nil,nil,plrarg) plrarg=plrarg and funcs.wfcofclass(plrarg,'Humanoid') plrarg=plrarg and (plrarg.RootPart or plrarg:GetPropertyChangedSignal'RootPart':Wait()) if plrarg then vars.funcs.ctp(getchar(),plrarg.CFrame*CFrame.new(0, 0, 2),strd[1]) end end;['desc']='creeptp - creeptp.iy improved'};
['Reservedpluginname']="base.tp-cmds"
}
return plug
