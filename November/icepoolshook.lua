local tb={
[10201298018]=function()
task.wait(2)
getgenv().funcs.vmp={}
local vmpdata={}
funcs.vmp.outfits=funcs.load("vmp_outfits.lua",{})
---get rid of annoying sound that made me think my computer was broken
for i,v in pairs(workspace:GetDescendants()) do
if v:IsA("Sound") and v.SoundId=="rbxassetid://9116267995" then
v:Stop()
v.SoundId=""
v.Volume=0
v.MaxDistance=0
end
end
funcs.vmp.unlock=function(x)
local spicelife=funcs.lplr.DataFolder.UnlockableItems:FindFirstChild(x,true)
if spicelife then
spicelife.Value=not spicelife.Value
end
end
funcs.vmp.saveoutfit=function(outfitname,whitelist)
whitelist=whitelist or {VampireAbility=true,HumanGadget=true}
funcs.vmp.outfits[outfitname]={}
for i,v in pairs(funcs.lplr.DataFolder.CurrentOutfit:GetChildren()) do
if not v.Name:lower():match("custom") and not table.find(whitelist,v.Name) then
table.insert(funcs.vmp.outfits[outfitname],{v.Name=="CharacterName" and "ChangeName" or v.Name,v.Value})
end
end
funcs.save("vmp_outfits.lua",funcs.vmp.outfits,true)
funcs.sendnotif("outfit: "..outfitname,"saved!","",5)
return funcs.vmp.outfits[outfitname]
end
local unlockalwayscat={"Shirts","Extra","Pants","Faces","HairColours","GunSkins"}
funcs.vmp.unlockoffsale=function()
for i,v in pairs(funcs.lplr.DataFolder.UnlockableItems:GetDescendants()) do
local myend=game:GetService("ReplicatedStorage").Storage.CharacterStuff:FindFirstChild(v.Name,true)
if v:IsA("BoolValue") and (not myend or myend and myend:FindFirstChild("Offsale") or table.find(unlockalwayscat,v.Parent.Name)) then
v.Value=true
elseif v:IsA("BoolValue") then
v.Value=false
end
end
end
funcs.vmp.loadoutfit = function(outfit)
local fit=funcs.vmp.outfits[outfit]
if fit then
local rem=getchar():WaitForChild("MainLocal",10):WaitForChild("Customize",10)
for i,v in pairs(fit) do
rem:FireServer(unpack(v))
task.wait(.6)
end
task.wait(.1)
funcs.sendnotif("outfit: "..outfit,"loaded","",5)
else
funcs.sendnotif("outfit: "..outfit,"not found","",5)
end

end
funcs.vmp.unlockall=function()
for i,v in pairs(funcs.lplr.DataFolder.UnlockableItems:GetDescendants()) do
if v:IsA("BoolValue") then
vmpdata[v]=v.Value
v.Value=true
end
task.wait()
end
funcs.sendnotif("unlocked","shirts,pants,abilities dont save","rbxassetid://9101806464",5)
end
funcs.vmp.default=function(x)
if not x then
for i,v in pairs(vmpdata) do
i.Value=v
end
vmpdata={}
funcs.sendnotif("locked","reset to default","rbxassetid://9101806464",5)
else
for i,v in pairs(funcs.lplr.DataFolder.UnlockableItems:GetDescendants()) do
if v.ClassName:match("Value") then
vmpdata[v]=v.Value
end
task.wait()
end
end
end
local replicated=game:GetService("ReplicatedStorage")
local function getsetting(values,setting,nm)
if setting==2 then
return values[3].Value and Color3.fromRGB(0,0,0) or values[1].Value and Color3.fromRGB(140,0,0) or values[2].Value and Color3.fromRGB(184,184,184) or Color3.fromRGB(150,81,107)
else
return values[3].Value and nm.." is dead (told you so)" or values[1].Value and nm.." is a sexy vampire" or values[2].Value and nm.." is a stupid detective daddy" or nm.." is a 'survivor' (yikes)"
end
end
local function linkedsword(v)
local linkedcharacter=funcs.plrs:FindFirstChild(v.Name)
if not linkedcharacter or linkedcharacter.Name==funcs.lplr.Name or not linkedcharacter.Character then return end
local values={v:WaitForChild("vampire",10),v:WaitForChild("detective",10),v:WaitForChild("died",10)}
local hook=funcs.addhook(linkedcharacter.Character,{color=getsetting(values,2),txtenabled=true,text=getsetting(values,1,v.Name),autoremove=true,dep={unpack(values),v,linkedcharacter.CharacterRemoving},transp=0.6})
if typeof(hook)=='string' then return end
local function chngv()
if hook and hook.textbox and hook.box then
local color=getsetting(values,2)
hook.box.Color3=color
hook.textbox.Text=getsetting(values,1,v.Name)
hook.textbox.TextColor3=color
end
end
for i,x in pairs(values) do
x.Changed:Connect(chngv)
end
linkedcharacter,linkedplayer=nil,nil
return {hook,values}
end
			local old_namecall
				old_namecall = hookmetamethod(game, "__namecall", newcclosure(function(instance,...)
				local ncm= getnamecallmethod()
				local args={...}
				if not checkcaller() and ncm=="FireServer" and #args>=1 and (table.find(args,"Walkspeed Exploit") or table.find(args,"exploit") or table.find(args,"kick") or (#args>=2 and (type(args[3])=="string" and args[3]:lower():match("exploit") or type(args[2])=="string" and args[2]:lower():match("exploit") or type(args[1])=="string" and args[1]:lower():match("exploit") ))) or type(args[1])=="string" and args[1]=="Hitbox Extension Check" then
                print(instance.Name)
				table.foreach(args,print)
				return
				end;
				return old_namecall(instance,...)
				end))

for i,v in pairs(replicated.InGamePlayerValues:GetChildren()) do
linkedsword(v)
end
local gunt=false
workspace.ChildAdded:Connect(function(gun)
if gun.Name=="gundropped" then
funcs.addhook(gun,{color=Color3.fromRGB(100,0,0),txtenabled=true,text="gun",autoremove=true,dep=values,transp=0.33})
if gunt and replicated.InGamePlayerValues:FindFirstChild(funcs.lplr.Name) then local piv,prr=getchar():GetPivot(),getchar().PrimaryPart or getchar():GetPropertyChangedSignal("PrimaryPart"):Wait() ; getchar():PivotTo(gun:GetPivot()) task.wait(.202) firetouchinterest(prr,gun,0)  firetouchinterest(prr,gun,1) getchar():PivotTo(piv) end
end
end)
funcs.vmp.con=replicated.InGamePlayerValues.ChildAdded:Connect(linkedsword)
local cu=funcs.lplr.Character:WaitForChild("MainLocal",10):WaitForChild("Customize",10)
--cu:FireServer("GunSkin", "Chocolate")
--cu:FireServer("VampireAbility", "Time")
--cu:FireServer("HumanGadget", "Strength")
local is_auto_enabled=false
local is_rr_enabled=false
local function garlic(car)
local garlicboyrepell=car:WaitForChild("charvalues",10)
garlicboyrepell=garlicboyrepell and garlicboyrepell:WaitForChild("caught",10)
if garlicboyrepell then
garlicboyrepell.Changed:Connect(function(x)
if x and is_auto_enabled then
local rem=car:WaitForChild("MainLocal",10)
local ch=getchar()
rem=rem and rem:WaitForChild("RemoteEvent",10)
while rem and garlicboyrepell and garlicboyrepell.Value==true and is_auto_enabled do
local cc =garlicboyrepell:WaitForChild("clickcounter",10)
if cc then cc.Value=40 end
--garlicboyrepell.Value=false
rem:FireServer("escape")
task.wait(.2)
end
local hmnoid=funcs.lplr.Character:FindFirstChildOfClass("Humanoid")
if is_rr_enabled and funcs.lplr.Character and funcs.lplr.Character==ch and hmnoid and hmnoid.MoveDirection.Magnitude>0 then for i = 1,30 do if not ch or not ch.Parent then break end local piv=ch:GetPivot() ch:PivotTo(piv + (piv.LookVector * .121)) ; piv=ch:GetPivot() ; ch:PivotTo(piv + (piv.LookVector * .121)) task.wait(0) end end
end
end)

end
end
garlic(getchar())
funcs.lplr.CharacterAdded:Connect(garlic)
local plug={
esc={func=function()
is_auto_enabled=not is_auto_enabled
funcs.sendnotif("autoesc","status: "..tostring(is_auto_enabled),"rbxassetid://6678521436",5)
end,desc="enable autoescape"};
dsh={func=function() is_rr_enabled=not is_rr_enabled funcs.sendnotif("autodsh","status: "..tostring(is_rr_enabled),"rbxassetid://6678521436",5) end;desc="autodash (requires you to be moving to look slightly more legit) (requires autoescape)"};
gg={func=function()
local gun=workspace:FindFirstChild("gundropped")
if gun then local prr=getchar().PrimaryPart or getchar():GetPropertyChangedSignal("PrimaryPart"):Wait() ; getchar():PivotTo(gun:GetPivot()) firetouchinterest(prr,gun,0)  firetouchinterest(prr,gun,1) end end,desc="gungrab"};
ag={func=function() gunt=not gunt
funcs.sendnotif("auto-gun","status: "..tostring(gunt),"rbxassetid://6678521436",5) end,desc="autogg"};
Reservedpluginname="VH2R"
}

return plug
end;
[5987989452]=function()
local vars={}
vars.itemtb={}
vars.funcs={}
for i,v in pairs(workspace:GetChildren()) do
if v:IsA('Folder') and string.match(v.Name,'Spawn',3) and v:FindFirstChildOfClass('ClickDetector') then 
vars.itemtb[string.split(v.Name:lower(),'spawn')[1]]=v:FindFirstChildOfClass('ClickDetector')
end
end

vars.funcs.itemgrab=function(strd,parg,str,cmd,real)
fireclickdetector(vars.itemtb[cmd])
end

vars.funcs.gotop=function(pos)
local bp=funcs.wfcofclass(getchar(),'BasePart') bp=bp and bp.AssemblyRootPart if not bp then return end local oldcf=bp.CFrame bp.CFrame=pos task.wait() bp.CFrame=oldcf ; oldcf=nil
 end

local plug={
['allit']={['func']=function() for i,v in pairs(vars.itemtb) do fireclickdetector(v) end end;['desc']='all items'};
['flask']={['func']=function() 
local flaskmesh = workspace:FindFirstChild("FlaskMesh",true)
if not flaskmesh then funcs.sendnotif("sus haxxx","no flask :(","rbxassetid://5891926006",5) return end
if flaskmesh.Parent:FindFirstChildOfClass("ClickDetector") then
fireclickdetector(flaskmesh.Parent:FindFirstChildOfClass("ClickDetector"))
end
flaskmesh=nil
end;['desc']='retard'};
['orange']={['func']=vars.funcs.gotop;['onlypass']=true;['args']=CFrame.new(-22.627584457397, -18.000005722046, 145.7900390625)};
['green']={['func']=vars.funcs.gotop;['onlypass']=true;['args']=CFrame.new(34.918026, 3.99999905, 51.9332619, -0.0087304078, 6.14552889e-08, 0.999961913, 2.25177494e-08, 1, -6.12610336e-08, -0.999961913, 2.19820571e-08, -0.0087304078)};
['slow']={['func']=vars.funcs.gotop;['onlypass']=true;['args']= CFrame.new(7.57155228, -13.0000029, 324.861847, -0.978740275, 9.83571891e-10, 0.205103561, -8.25161536e-11, 1, -5.18925036e-09, -0.205103561, -5.09585263e-09, -0.978740275)};
['Reservedpluginname']='monkegame'
}
for i,v in pairs(vars.itemtb) do plug[i]={['func']=vars.funcs.itemgrab;['desc']='grab item'} end
return plug
end;
[11305669230]=function()
local rtb={}
rtb.kb=function(x)
if x.Name=="Boss" and x:IsA("Model") and funcs.wfcofclass(x,"Humanoid") and powersupply.cmds['tk'] then
local mbp=funcs.wfcofclass(funcs.lplr,"Backpack")
mbp=mbp and funcs.wfcofclass(mbp,"Tool",10,false,{['Name']='RealKnife'})
if mbp then mbp.Parent=getchar() mbp=nil end
powersupply.cmds['tk'][1]({},x)
end
end

rtb.kbr=function(x)
if x.Name=="Boss" and x:IsA("Model") and rtb.cboss then
local st=os.clock() ; repeat getchar():PivotTo(rtb.cboss.Parent:GetPivot()) task.wait(1) fireclickdetector(rtb.cboss,3) until not rtb.cboss or workspace:FindFirstChild("Boss") and workspace:FindFirstChild("Boss")~=x or os.clock()-st>10 ; st=nil
end
end
local plug={
['Reservedpluginname']='UTLC:S';
['akillb']={['func']=function() 
if rtb.kbc then rtb.kbc=rtb.kbc:Disconnect() rtb.kbcc=rtb.kbcc:Disconnect() for i,v in pairs(rtb.cbcon) do v:Disconnect() end rtb.cbcon=nil  else rtb.kbc=workspace.ChildAdded:Connect(rtb.kb) rtb.kbcc=workspace.ChildRemoved:Connect(rtb.kbr) for i,v in pairs(workspace:GetChildren()) do rtb.kb(v) end 
rtb.cbcon={} for i,v in pairs(workspace.Doors:GetDescendants()) do if v:IsA("ClickDetector") then table.insert(rtb.cbcon,v.MouseClick:Connect(function() if rtb.cboss~=v then rtb.cboss=v funcs.sendnotif("UTLC:S\\B",rtb.cboss.Parent.Name,rtb.cboss.Parent:FindFirstChildOfClass("Decal").Texture,5) end end)) end end end
funcs.deb:AddItem(workspace:FindFirstChild("Attacks"),0)
funcs.sendnotif("sutpiddumb\\comedygoldhook\\UTLC:S",rtb.kbc and "autokillboss" or "snailmode","",5)
end;['desc']='requires char-manip plugin'}
}
return plug
end;
[9928218161]=function()
local vars={['rev']=game:GetService('ReplicatedStorage'):WaitForChild("Ragdoll",40):WaitForChild("revivePlayer",40);['ab']=game:GetService("ReplicatedStorage").Remotes.Ability.Server}
local plug={
['stam']={['func']=function()
getchar():SetAttribute('StaminaRegenerationRate',10^5)
funcs.sendnotif('NightOfNights\\bamb','stamina regen big','rbxassetid://8119590978',5)
end;['desc']='instantly regen stamina'};
['ltesp']={['func']=function()
if not workspace:FindFirstChild('Map') then funcs.sendnotif('nomap','nomap','',5) return end
for i,v in pairs(game:GetService("Workspace").Map.Scripted.Safes:GetChildren()) do funcs.addhook(v) end
for i,v in pairs(game:GetService("Workspace").Map.Scripted.Misc:GetChildren()) do funcs.addhook(v) end
funcs.sendnotif('NightOfNights\\bamb','ltesp','rbxassetid://8119590978',5)
end;['desc']='esp stuff'};
['rev']={['func']=function(a,aa)
aa=aa and funcs.xgetplr(aa,true)
if aa then
vars.rev:FireServer(aa)
vars.rev:FireServer(aa,'Hold')
--vars.rev:FireServer(aa)
--vars.rev:FireServer(aa,'StopHold')
vars.rev:FireServer(aa)
funcs.sendnotif('NightOfNights\\thebamb','rev: '..aa.DisplayName,'rbxassetid://8119590978',5)
end
end;['desc']='revive plr'};
['shk']={['func']=function(a,aa)
aa=aa and funcs.xgetplr(aa,true)
if aa then vars.ab:FireServer("Shock",{aa}) end
end};
['Reservedpluginname']='Night Of Nights'
}
return plug
end;
[198817751]=function()
local vars={['gdata']=workspace.GameData.Players;['role3']={['color']=Color3.fromRGB(100,0,0),['txt']=' is a vampire...';['job']='vhesp'};['role2']={['txt']=' is a detective...';['job']='vhesp'};['role1']={['txt']=' is a soon-to-be-dead...';['color']=Color3.fromRGB(0,10,10);['job']='vhesp'}}
vars.funcs={}
vars.funcs.replr=function(plr)
	local val=vars.gdata:WaitForChild(plr.Name,60)
	if not val or not val:WaitForChild('Mode',5) then return end
	local thech=plr.Character
	if thech and vars['role'..val.Mode.Value] and thech:WaitForChild('Head',2) and not table.find(funcs.hookedinst,thech:WaitForChild('Head',2)) and not table.find(funcs.hookedinst,val.Mode) then
	local tehtb=table.clone(vars['role'..val.Mode.Value])
	tehtb['dep']={plr.CharacterRemoving} tehtb['txt']=plr.DisplayName..tehtb.txt..' ('..plr.Name..')' local hk=funcs.addhook(thech:WaitForChild('Head',2),tehtb)
	tehtb=nil
	
	local thec
	thec=val.Mode.Changed:Connect(function()
	if hk and hk.box and hk.textbox then
	local tb=vars['role'..val.Mode.Value]
	if not tb then hk.justquit() thec:Disconnect() thec=nil return end
	if tb['color'] then hk.box.Color3=tb['color'] hk.textbox.TextColor3=tb['color'] end if tb['txt'] then hk.textbox.Text=tb['txt'] end
	else
	thec:Disconnect() thec=nil
	end
	end)
	
	table.insert(funcs.hookedinst,val.Mode)
	val.Mode.Changed:Connect(function()
	if plr and vars['role'..val.Mode.Value] then
	vars.funcs.replr(plr)
	end
	end)
	end

	
end
vars.funcs.ref=function()
for i,v in pairs(funcs.plrs:GetPlayers()) do
if v~=funcs.lplr then task.spawn(vars.funcs.replr,v) end
end
end
vars.funcs.onplr=function(plr)
plr.CharacterAdded:Connect(function() vars.funcs.replr(plr) end)
vars.funcs.replr(plr)
end
for i,v in pairs(funcs.plrs:GetPlayers()) do
if v~=funcs.lplr then task.spawn(vars.funcs.onplr,v) end
end
workspace.CurrentCamera.ChildAdded:Connect(function(x) if x.Name=='IntroGame' then task.wait(1) vars.funcs.ref() end end)
funcs.plrs.PlayerAdded:Connect(vars.funcs.onplr)
vars.escvp=workspace.Events.Vampire.EscapeVampire
local plug={
['esc']={['func']=function()
if funcs.lplr:FindFirstChildOfClass('PlayerGui').GameScreen.Game.Escape.Visible then
task.wait(.3)
vars.escvp:FireServer(nil,true)
end
end;['desc']='escape vampire'};
['Reservedpluginname']='vh2'
}
vars.funcs.aescseq=function(v)
if v.Name=='GameScreen' and v:WaitForChild('Game',5) and v:WaitForChild('Game',5):WaitForChild('Escape',5) then
plug['aesc']['func']() plug['aesc']['func']()
end
end
plug['aesc']={['func']=function()
if not vars.aesc_con2 then
plug.esc.func()
vars.aesc_con=funcs.lplr:FindFirstChildOfClass('PlayerGui').GameScreen.Game.Escape:GetPropertyChangedSignal('Visible'):Connect(plug.esc.func)
vars.aesc_con2=funcs.lplr:FindFirstChildOfClass('PlayerGui').ChildAdded:Connect(vars.funcs.aescseq)
funcs.sendnotif('allistrue','see_no_evil','rbxassetid://11151804223',5)
else
if vars.aesc_con then vars.aesc_con=vars.aesc_con:Disconnect() end
vars.aesc_con2=vars.aesc_con2:Disconnect()
funcs.sendnotif('allisfalse','see_evil','rbxassetid://11151804223',5)
end
end;['desc']='autoescape vampire'}
return plug
end;
[9143982021]=function()
local plug={
["rd"]={["func"]=function() if math.random(1, 99) == 1 then
	v4 = "nuke";
elseif math.random(1,70)==1 then
v4="timeclock";
elseif math.random(1, 18) == 1 then
	v4 = "lightning";
elseif math.random(1, 13) == 1 then
	v4 = "rocket";
else
v4=tmpv3[math.random(1,#tmpv3)]
end
if alrd==true then
funcs.sendnotif(v4:upper().."(R)",v4:upper(),"rbxassetid://6678521436",4)
return
end
funcs.sendnotif(v4:upper().."(R)",v4:upper(),"rbxassetid://6678521436",9)
local con
con = mouse.KeyDown:Connect(function(p1)
	if p1 == "r" and getchar():FindFirstChild("Humanoid").Health > 0 then
		funcs.lplr.PlayerGui.ItemGui.RemoteEvent:FireServer(v4)
		alrd=false
		con:Disconnect()
	end;
end);
alrd=true
getchar().Humanoid.Died:Connect(function()
alrd=false
con:Disconnect()
end) end,["desc"]="random, 50+% higher chance of good stuff"};
["ITEM_CMD"]={["func"]=function(strd,plrarg,x,cmd,args,RealCmd)

 end,["aliases"]={},["displayname"]=""}


} --plug
end

} --full

tb=tb[game.PlaceId]
if type(tb)=='function' then return tb() elseif type(tb)=='string' then local fun=loadstring(game:HttpGet(tb)) setfenv(fun,getfenv()) fun=fun() return fun end
return tb
