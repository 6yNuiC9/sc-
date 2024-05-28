local vars={['braintransparency']=.4}
vars.funcs={}
vars.cons={}
vars.funcs.espclass=function(class)
for i,v in pairs(workspace:GetDescendants()) do
if v:IsA(class) and (v.Parent:IsA('BasePart') or v.Parent:IsA('MeshPart')) then
funcs.addhook(v.Parent,{['job']=class..'esp';['color']=(class=='TouchTransmitter' and Color3.fromRGB(100,0,0) or class=='ClickDetector' and Color3.fromRGB(0,0,100) or Color3.fromRGB(255,255,255))})
end
if i%2500==0 then task.wait() end --dont crash me uwu
end
end

vars.funcs.resp=function(hdrr) funcs.deb:AddItem(funcs.getholder(hdrr),0) end

vars.funcs.chadded=function(ch)
funcs.addhook(ch,{['job']='cmd_pesp';['txt']=ch.Name})
end
vars.funcs.padded=function(plr)
if vars.pesp then table.insert(vars.cons,plr.CharacterAdded:Connect(vars.funcs.chadded)) end
end
vars.braindeadplrs={}
vars.funcs.braindeadesp=function(plr,ma)
if not vars.braindeadplrs[plr.UserId] then vars.braindeadplrs[plr.UserId]={['ma']=ma==true} end
local plrch=plr.Character or plr.CharacterAdded:Wait()
local plrh=plrch and plrch:WaitForChild('Head',5)
if not plrh then return end
local plrhum=plrch and funcs.wfcofclass(plrch,'Humanoid')
local BillboardGui = Instance.new("BillboardGui")
funcs.deb:AddItem(vars.braindeadplrs[plr.UserId][2],0)
vars.braindeadplrs[plr.UserId][2]=BillboardGui
local TextLabel = Instance.new("TextLabel")
BillboardGui.Parent = funcs.getholder('braindeadesp')
BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BillboardGui.Active = true
BillboardGui.Adornee = plrh
BillboardGui.AlwaysOnTop = true
BillboardGui.MaxDistance = 10000
BillboardGui.Size = UDim2.new(4, 0, 1, 0)
BillboardGui.SizeOffset = Vector2.new(0, 4.5)
TextLabel.Parent = BillboardGui
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Font = Enum.Font.SourceSansSemibold
TextLabel.TextTransparency  = vars.braintransparency
TextLabel.TextSize = 15
TextLabel.TextYAlignment = Enum.TextYAlignment.Top
TextLabel.Text=plr.DisplayName
TextLabel.TextColor3 = Color3.new(1,1,1)
local con
con = plr.CharacterRemoving:Connect(function()
funcs.deb:AddItem(BillboardGui,0)
con:Disconnect()
end)
if plrhum then
local con2
local function resst()
if TextLabel then
TextLabel.Text=plr.DisplayName..": "..math.ceil(plrhum.Health).."/"..math.ceil(plrhum.MaxHealth) else con2:Disconnect() end
end
resst()
con2=plrhum.HealthChanged:Connect(resst)
end
if not vars.braindeadplrs[plr.UserId][1] then vars.braindeadplrs[plr.UserId][1]=plr.CharacterAdded:Connect(function() vars.funcs.braindeadesp(plr,ma) end) end
end

local plug={
['tesp']={['func']=vars.funcs.espclass;['args']='TouchTransmitter',['onlypass']=true;['desc']='untesp'};
['cesp']={['func']=vars.funcs.espclass;['args']='ClickDetector',['onlypass']=true;['desc']='uncesp'};
['ppesp']={['func']=vars.funcs.espclass;['args']='ProximityPrompt',['onlypass']=true;['desc']='unppesp'};
['unppesp']={['func']=vars.funcs.resp;['args']='ProximityPromptesp',['onlypass']=true;['desc']='unppesp'};
['untesp']={['func']=vars.funcs.resp;['args']='TouchTransmitteresp',['onlypass']=true};
['uncesp']={['func']=vars.funcs.resp;['args']='ClickDetectoresp',['onlypass']=true};
['pesp']={['func']=function(a,aa)
if vars.pesp then vars.pesp:Disconnect() vars.pesp=nil for i,v in pairs(vars.cons) do v:Disconnect() end vars.cons={} funcs.deb:AddItem(funcs.getholder('cmd_pesp'),0) else 
for i,v in pairs(funcs.plrs:GetPlayers()) do if v.Character then task.spawn(vars.funcs.chadded,v.Character)  table.insert(vars.cons,v.CharacterAdded:Connect(vars.funcs.chadded)) end end vars.pesp=funcs.plrs.PlayerAdded:Connect(vars.funcs.padded)
end end;['desc']='toggle'};
['transesp']={['func']=function(a,aa)
local hlder=funcs.instanceholder:FindFirstChild('transesp')
if hlder then funcs.deb:AddItem(hlder,0) funcs.sendnotif('uncat\\transesp','disabled','rbxassetid://11012215782',5) return else hlder=funcs.getholder('transesp') funcs.sendnotif('uncat\\transesp','enabled','rbxassetid://11012215782',5) end
aa=aa and tonumber(aa) or .7
for i,v in pairs(workspace:GetDescendants()) do
if (v:IsA('BasePart') or v:IsA('MeshPart')) and v.Transparency >= aa and not v.Parent:FindFirstChildOfClass('Humanoid') then
funcs.addhook(v,{['aot']=false;['color']=Color3.fromRGB(0,35,0);['job']=hlder})
end
if i%220==0 then task.wait() end
end
end;['desc']='toggle: high transparency esp: > (arg[1] or .7)'};
['toolspy']={['func']=function(ksqsjqis,THEARG)
THEARG=THEARG and tonumber(THEARG) or .5
if vars.tspy then task.wait() for i,v in pairs(vars.tspy.cons) do if v then v=v:Disconnect() end end vars.tspy=nil  funcs.deb:AddItem(funcs.instanceholder:FindFirstChild('toolspy'),0) return end
vars.tspy={}
vars.tspy.cons={}
vars.tspy.funcs={}
--[[kindaunoptimizedstillbetterthanmosthough
local funcs = {}
funcs.normalizeblue = function(nnnn)
return "%"..nnnn
end
funcs.normalizemagic = function(magic)
return string.gsub(magic,"[%(+%)+%^+%*+%$+%.+%[+%]+%++%-+%?+%%+]",funcs.normalizeblue)
end
funcs.plrs = game:GetService("Players")--]]
vars.tspy.funcs.addn=function(plr)
local nm = plr.Character and plr.Character:GetChildren()
local v = plr.Character and plr.Character:WaitForChild("Head",10) or plr.Character and (plr.Character.PrimaryPart or funcs.wfcofclass(plr.Character,'BasePart',5,true) and plr.Character:FindFirstChildWhichIsA('BasePart').AssemblyRootPart)
if v ~= nil then
local BillboardGui = Instance.new("BillboardGui")
local TextLabel = Instance.new("TextLabel")
BillboardGui.Parent = funcs.getholder('toolspy')
BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BillboardGui.Active = true
BillboardGui.Adornee = v
BillboardGui.AlwaysOnTop = true
BillboardGui.MaxDistance = 10000
BillboardGui.Size = UDim2.new(4, 0, 1, 0)
BillboardGui.SizeOffset = Vector2.new(0, 4.5)
local tooltb={}
local con
con = plr.CharacterRemoving:Connect(function()
if BillboardGui then
BillboardGui=BillboardGui:Destroy()
end
tooltb=nil
con:Disconnect()
end)
local toolstring = ""
TextLabel.Parent = BillboardGui
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Font = Enum.Font.SourceSansSemibold
TextLabel.TextTransparency  = THEARG
local tm = ""

if plr.Neutral ~= true and plr.Team then
tm = " ("..plr.Team.Name..")"
TextLabel.TextColor3 = plr.TeamColor.Color
else
tm = " (Neutral)"
TextLabel.TextColor3 = Color3.new(1,1,1)
end
TextLabel.TextSize = 15
TextLabel.TextYAlignment = Enum.TextYAlignment.Top
local p = plr:FindFirstChildOfClass('Backpack') and plr:FindFirstChildOfClass('Backpack'):GetChildren()
local nu = 1
local hpt = ""
local hm = plr.Character:FindFirstChildOfClass("Humanoid") or plr.Character:WaitForChild("Humanoid",10)
if hm then
hpt = plr.DisplayName..": "..math.ceil(hm.Health).."/"..math.ceil(hm.MaxHealth)..tm.."\n"
TextLabel.Text = hpt..toolstring
hm.HealthChanged:Connect(function()
hpt = plr.DisplayName..": "..math.ceil(hm.Health).."/"..math.ceil(hm.MaxHealth)..tm.."\n"
TextLabel.Text = hpt..toolstring
end)
end

table.insert(vars.tspy.cons,plr:GetPropertyChangedSignal("Team"):Connect(function()
if plr.Neutral ~= true and plr.Team then
tm = " ("..plr.Team.Name..")"
TextLabel.TextColor3 = plr.TeamColor.Color
else
tm = " (Neutral)"
TextLabel.TextColor3 = Color3.new(1,1,1)
end
hpt = (hm and plr.DisplayName..": "..math.ceil(hm.Health).."/"..math.ceil(hm.MaxHealth)..tm.."\n") or plr.DisplayName..tm.."\n"
TextLabel.Text = hpt..toolstring
end))

for m,x in pairs(nm) do
if x:IsA("Tool") then
local tn = string.gsub(x.Name,"\n"," ")
if x ~= nil and nu%4 == 0  then
toolstring = toolstring.."\n"..tn
TextLabel.Text = hpt..toolstring
nu=1
elseif x ~= nil then
toolstring = toolstring..tn..","
TextLabel.Text = hpt..toolstring
nu=nu+1
end
tooltb[x]=tn
BillboardGui.SizeOffset = BillboardGui.SizeOffset+Vector2.new(0,.35)
end
end

table.insert(vars.tspy.cons,plr.Character.ChildAdded:Connect(function(n)
local tn = string.gsub(n.Name,"\n"," ")
if n:IsA("Tool") then
if tooltb[n] then
return
elseif nu%4 == 0 and n:IsA("Tool") then
toolstring = toolstring.."\n"..tn.." (EQUIPPED),"
TextLabel.Text = hpt..toolstring
nu=1
elseif n:IsA("Tool") then
toolstring = toolstring..tn.." (EQUIPPED),"
TextLabel.Text = hpt..toolstring
nu=nu+1
end
tooltb[n]=tn
BillboardGui.SizeOffset = BillboardGui.SizeOffset+Vector2.new(0,.35)
end
end))

table.insert(vars.tspy.cons,plr.Character.ChildRemoved:Connect(function(n)
if tooltb and tooltb[n] then
local tn = funcs.normalizemagic(tooltb[n])
local repl = (string.find(toolstring,"\n"..tn.." %(EQUIPPED%),") and string.gsub(toolstring,"\n"..tn.." %(EQUIPPED%),","",1)) or (string.find(toolstring,tn.." %(EQUIPPED%),",1) and string.gsub(toolstring,tn.." %(EQUIPPED%),","",1)) or toolstring
toolstring = repl
TextLabel.Text = hpt..toolstring
nu=nu-1
BillboardGui.SizeOffset = BillboardGui.SizeOffset-Vector2.new(0,.35)
tooltb[n]=nil
end

end))

if p then

for m,x in pairs(p) do
local tn = string.gsub(x.Name,"\n"," ")
if tooltb[n] then
continue
elseif x ~= nil and x:IsA("Tool") and nu%4 == 0 then
toolstring = toolstring.."\n"..tn..","
TextLabel.Text = hpt..toolstring
nu = 1
elseif x ~= nil and x:IsA("Tool") then
toolstring = toolstring..tn..","
TextLabel.Text = hpt..toolstring
nu=nu+1
end
tooltb[x]=tn
BillboardGui.SizeOffset = BillboardGui.SizeOffset+Vector2.new(0,.35)

end

table.insert(vars.tspy.cons,plr.Backpack.ChildAdded:Connect(function(n)
local tn = string.gsub(n.Name,"\n"," ")
if n:IsA("Tool") then
if tooltb[n] then

elseif nu%4 == 0 then
toolstring = toolstring.."\n"..tn..","
TextLabel.Text = hpt..toolstring
nu = 1
else
toolstring = toolstring..tn..","
TextLabel.Text = hpt..toolstring
nu=nu+1
end
tooltb[n]=tn
BillboardGui.SizeOffset = BillboardGui.SizeOffset+Vector2.new(0,.35)

end
end))

table.insert(vars.tspy.cons,plr.Backpack.ChildRemoved:Connect(function(n)
if tooltb and tooltb[n] then
local tn = funcs.normalizemagic(string.gsub(n.Name,"\n"," "))
local repl = (string.find(toolstring,"\n"..tn..",") and string.gsub(toolstring,"\n"..tn..",","",1)) or (string.find(toolstring,tn..",") and string.gsub(toolstring,tn..",","",1)) or toolstring
toolstring = repl
TextLabel.Text = hpt..toolstring
nu-=1
BillboardGui.SizeOffset = BillboardGui.SizeOffset-Vector2.new(0,.35)
tooltb[n]=nil
end
end))

end
end
end

vars.tspy.funcs.plrj=function(ml)
table.insert(vars.tspy.cons,ml.CharacterAdded:Connect(function(L)
vars.tspy.funcs.addn(ml)
end))
vars.tspy.funcs.addn(ml)
end
for i,plr in pairs(funcs.plrs:GetPlayers()) do
task.spawn(vars.tspy.funcs.plrj,plr)
end
table.insert(vars.tspy.cons,funcs.plrs.PlayerAdded:Connect(vars.tspy.funcs.plrj))
end;['aliases']={['tspy']='toolspy'};['desc']='toggle, arg[1]=transparency: default .5'};
['presp']={['func']=function(a,aa)
if vars.braincon then vars.braincon=vars.braincon:Disconnect() for i,v in pairs(vars.braindeadplrs) do if v and not v['ma'] then v[1]:Disconnect() funcs.deb:AddItem(v[2],0) vars.braindeadplrs[i]=nil end end return end
vars.braintransparency=aa and tonumber(aa) or .5
for i,v in pairs(funcs.plrs:GetPlayers()) do if not vars.braindeadplrs[v.UserId] then task.spawn(vars.funcs.braindeadesp,v) end end
vars.braincon=funcs.plrs.PlayerAdded:Connect(vars.funcs.braindeadesp)
end;['desc']='toggle, arg[1]=transparency'};
['loc']={['func']=function(a,aa)
aa=aa and funcs.xgetplr(aa,true)
vars.braintransparency=a[1] and tonumber(a[1]) or .5
if aa then if vars.braindeadplrs[aa.UserId] then vars.braindeadplrs[aa.UserId][1]:Disconnect() funcs.deb:AddItem(vars.braindeadplrs[aa.UserId][2],0) vars.braindeadplrs[aa.UserId]=nil return end
vars.funcs.braindeadesp(aa,true) end end;['desc']='toggle: locate plrarg[1], arg[2] = transparency'};
['Reservedpluginname']='stupidesp'
}

return plug
