local vars={
['gamereq']=true,
['funcs']={},['nis']='NetworkIsSleeping',['refd']=.5
}
local tween
vars.funcs.bloodforevening=function(input,gameprocessed)
if (not vars.gamereq or not gameprocessed) then
if input.KeyCode == Enum.KeyCode.Z then
funcs.lplr:ClearCharacterAppearance()
local ch=getchar()
local h = funcs.wfcofclass(ch,'Humanoid',5)
if not h then return end
local hc=h:Clone()
hc.Parent = ch

h:Destroy()

for _,v in next,funcs.wfcofclass(funcs.lplr,'Backpack',10):GetDescendants() do
    if v.ClassName == "Tool" then
        v.Parent = ch
    end
end
ch,h,hc=nil,nil,nil
vars.reddevredemption=true
elseif input.KeyCode == Enum.KeyCode.M and vars.reddevredemption then
vars.reddevredemption=false
local tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(300, Enum.EasingStyle.Linear)
local ch=getchar() local rp=ch:FindFirstChildWhichIsA('BasePart') rp=ch and ch.AssemblyRootPart
if rp and ch then
tween = tweenService:Create(rp, tweenInfo, {CFrame = CFrame.new(0, -1000, 0)})
tween:Play()
task.wait(5)
if ch and funcs.lplr.Character==ch then
plug.ref()
end
end
elseif input.KeyCode == Enum.KeyCode.N and vars.reddevredemption then
vars.reddevredemption=false
getchar():PivotTo(CFrame.new(Random.new():NextNumber(60000000000,100000000000),Random.new():NextNumber(60000000000,100000000000),Random.new():NextNumber(60000000000,100000000000)))
elseif input.KeyCode == Enum.KeyCode.B and vars.reddevredemption then
vars.reddevredemption=false
plug.ref()
end

end
end

vars.funcs.finalnyojikko=function(char,bp,vHRP,tmtb)
	local res,lastre=false,os.clock()-tmtb.lastre
		for _, v in ipairs(char:GetChildren()) do
			if v:IsA('BackpackItem') and v:FindFirstChild('Handle') then
				if v.Parent==char and lastre>=.066 then tmtb.lastre=os.clock() v.Parent=bp v.Parent=char end
				firetouchinterest(v.Handle, vHRP, 0)
				res=true
			end
		end
	if tmtb.tls then tmtb.tls=res end tmtb.inj=false
end

vars.funcs.eqtool=function(wheneverythinggoeswrong)
local hmnoid=funcs.wfcofclass(getchar(),'Humanoid')
if hmnoid and wheneverythinggoeswrong and wheneverythinggoeswrong.Parent and wheneverythinggoeswrong:IsA('BackpackItem') and wheneverythinggoeswrong.Parent~=getchar() then
task.defer(hmnoid.EquipTool,hmnoid,wheneverythinggoeswrong)
end
hmnoid=nil
end

vars.funcs.re=function(x)
		if x then local bp=funcs.lplr.CharacterAdded:Wait() if vars.refd>=0 then task.wait(vars.refd) end if bp then bp:PivotTo(x) end end
end
vars.funcs.ref=function(x)
local Char=funcs.lplr.Character local cf=typeof(x)=='CFrame' and x or Char and Char:FindFirstChildWhichIsA'BasePart' if typeof(cf)=='Instance' then cf=cf.AssemblyRootPart and cf.AssemblyRootPart.CFrame end
	local hum=Char and Char:FindFirstChildWhichIsA('Humanoid') if hum then hum:ChangeState(15) end
	if Char then Char:ClearAllChildren() end
	local newChar = Instance.new("Model")
	newChar.Name=Char.Name
	newChar.Parent = workspace
	funcs.lplr.Character = newChar
	task.wait()
	funcs.lplr.Character = Char
	funcs.deb:AddItem(newChar,0) Char=nil funcs.lplr.Character=nil vars.funcs.re(cf)
end

vars.funcs.tthing=function(strt,nn,str,cmd,arg)
	local thp=nn and funcs.xgetplr(nn,true)
	if not thp then return end settings().Physics.AllowSleep=false
	local v = thp.Character or thp.CharacterAdded:Wait()
	local ccam=workspace.CurrentCamera if ccam and v then ccam.CameraSubject = v end
	local Char = getchar()
	local hum = Char:FindFirstChildWhichIsA('Humanoid')
	local hrp = hum and hum.RootPart
	local hrppos = hrp and hrp.CFrame
	local bp=strt[1] and funcs.lplr:FindFirstChildWhichIsA("Backpack") 
	if bp and bp:FindFirstChildOfClass('Tool') then
	if strt[1]=="2" then
	for i,v in next,bp:GetChildren() do
	if v:IsA("Tool") then
	v.Parent=Char
	end
	end
	elseif strt[1]=="1" then
	bp:FindFirstChildOfClass("Tool").Parent=Char
	end
	end
	if not (Char:FindFirstChildOfClass("Tool") and hrp) then
	funcs.sendnotif(string.format("cmds/toolthing/%s",arg.cmd or '?'),string.format('you have no bitches (tools or hrp), %s (%s)',thp.DisplayName,thp.Name),"rbxassetid://6678521436",4) ccam.CameraSubject=hum return
	end ccam=nil 
	local vHRP = v:WaitForChild("HumanoidRootPart",5) if not vHRP then return end
	hrp.CustomPhysicalProperties=PhysicalProperties.new(vHRP.Mass*10,0,0) local hc=hum:Clone() hc:ClearAllChildren() if hum then hum.PlatformStand=false hum.Parent=nil end hc.Parent = Char --coroutine.wrap(vars.funcs.re)(hrppos)
	local tmtb={['tls']=true,['onemore']=0,['i']=1,['lastre']=-1}
	while Char and Char.Parent and vHRP and vHRP.Parent and hrp and hrp.Parent and tmtb.tls do
	tmtb.i=tmtb.i~=2 and 2 or 1 sethiddenproperty(hrp,vars.nis,false) hrp.CFrame=vHRP.CFrame*CFrame.new(0,0,-.05) hrp.AssemblyLinearVelocity=vHRP.AssemblyLinearVelocity*(Vector3.one*1.2)
	if not tmtb.inj then tmtb.inj=true coroutine.wrap(vars.funcs.finalnyojikko)(Char,bp,vHRP,tmtb) end
	sethiddenproperty(hrp,vars.nis,false) hrp.AssemblyLinearVelocity=vHRP.AssemblyLinearVelocity*(Vector3.one*1.4) hrp.CFrame=vHRP.CFrame
	task.wait(math.clamp(funcs.lplr:GetNetworkPing()*1.3,1/55,0.3))
	if not tmtb.tls and tmtb.onemore<1 then tmtb.onemore+=1 tmtb.tls=true end
	end
	for i=1,10 do if hrp and hrp.Parent and vHRP and vHRP.Parent then sethiddenproperty(hrp,vars.nis,false) if arg.cf then hrp.CFrame=arg.cf==true and hrppos or arg.cf elseif arg.rndcf then hrp.CFrame=CFrame.new(Vector3.one*Random.new():NextNumber(arg.rndcf,arg.rndcfm)) end else break end task.wait(funcs.lplr:GetNetworkPing()*1.2) end
	task.delay(1,vars.funcs.ref,hrppos)
	if strt[2]~="nn" then funcs.sendnotif(string.format("cmds/toolthing/%s",arg.cmd or '?'),string.format('%s %s (%s)',arg.edcmd or '?ed',thp.DisplayName,thp.Name),"rbxassetid://6678521436",4) end settings().Physics.AllowSleep=true
end
local plug={
["desc"]={desc="Z - kidnap M - hell N - Void B - Refresh"};
["tky"]={func=function(strt,plrarg) if vars.keysen then vars.keysen:Disconnect() vars.keysen=nil else vars.keysen=funcs.uip.InputBegan:Connect(vars.funcs.bloodforevening) end if plrarg~="nn" then funcs.sendnotif("cmds/toolthing/tky",vars.keysen and "Z - kidnap M - hell N - Void B - Refresh" or "false","rbxassetid://6678521436",10) end end,desc="toggle keybinds (default: off)"};
["proc"]={func=function(strt,plrarg) vars.gamereq=not vars.gamereq; if plrarg~="nn" then funcs.sendnotif("cmds/toolthing/proc",vars.gamereq and "true" or "false","rbxassetid://6678521436",5) end end,desc="disables gamereq requirement, use if keybinds dont work"};
["ref"]={['func']=vars.funcs.ref,['desc']="refresh character"};
['f3x']={['func']=function() loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)() end;['desc']='building tools, untrustworthy loadstring'};
['grabtools']={['func']=function(a,aa)
if not funcs.wfcofclass(getchar(),'Humanoid') then return end
for i,v in next,workspace[aa and 'GetDescendants' or 'GetChildren'](workspace) do
if v:IsA('BackpackItem') then
vars.funcs.eqtool(v)
end
if i%3200==0 then task.wait() end
end
if vars.grabcon then vars.grabcon=vars.grabcon:Disconnect() end
vars.grabcon=workspace[aa and 'DescendantAdded' or 'ChildAdded']:Connect(vars.funcs.eqtool)
funcs.sendnotif('toolthing\\grabtools\\'..(aa and 'DescendantAdded' or 'ChildAdded'),vars.grabcon~=nil and 'true' or 'false','rbxassetid://11012215782',5) 
end;['desc']='specify arg[1] for descendants, default GetChildren'};
['ungrabtools']={['func']=function() if vars.grabcon then vars.grabcon=vars.grabcon:Disconnect() funcs.sendnotif('toolthing\\grabtools','false','rbxassetid://11012215782',5) end end};
['rjgtool']={['func']=function(strt,strd,str) powersupply.cmds['gtool'][1](strt,strd,str) end;['desc']='givetools and then rejoin'};
['equiptools']={['func']=function() local bp=funcs.wfcofclass(funcs.lplr,'Backpack') if bp then for i,v in next,bp:GetChildren() do if v:IsA('Tool') then v.Parent=getchar() end end bp=nil end end;['aliases']={['eqtools']='equiptools'}};
['actvtools']={['func']=function() for i,v in next,getchar():GetChildren() do if v:IsA('Tool') then v:Activate() end end end};
['dst']={['func']=function() funcs.deb:AddItem(getchar():FindFirstChildOfClass('Tool'),0) end,['desc']='destroy one equipped tool'};
['dsta']={['func']=function() for i,v in next,getchar():GetChildren() do if v:IsA('Tool') then funcs.deb:AddItem(v,0) end end end,['desc']='destroy all equipped tools'};
['gtool']={['func']=vars.funcs.tthing,['args']={['cmd']='gtool',['edcmd']='gtools'},['desc']='givetools to <playerarg[1]> if <arg[2]>="1" then equip one elseif <arg[2]>=="2" equip all'},
['void']={['func']=vars.funcs.tthing,['args']={['cmd']='void',['edcmd']='voided',['rndcf']=60000000,['rndcfm']=9e10}},
['bring']={['func']=vars.funcs.tthing,['args']={['cmd']='bring',['edcmd']='brought(?)',['cf']=true}},
['refd']={['func']=function(a,nn) nn=nn and tonumber(nn) if nn then vars.refd=nn end end,['desc']='refdelay before tping'}, 
['kill']={['func']=function(strt,nn,str,cmd,arg) local fpds=workspace.FallenPartsDestroyHeight workspace.FallenPartsDestroyHeight=-9e9 arg.cf=CFrame.new(0,fpds*.85,0) vars.funcs.tthing(strt,nn,str,cmd,arg) workspace.FallenPartsDestroyHeight=fpds end,['args']={['cmd']='kill',['edcmd']='killed(?)'}},
['Reservedpluginname']="base.tool-manipulation"
}

return plug
