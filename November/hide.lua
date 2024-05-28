local hidden = {}
local vrs={} vrs.hiddendeath=Instance.new('Folder') vrs.prnil=function(x,plr) hidden[plr.UserId].oldpar=x.Parent x.Parent=nil local cccon;cccon=x.AncestryChanged:Connect(function() if hidden[plr.UserId] then task.defer(coroutine.running()) coroutine.yield() hidden[plr.UserId].oldpar=x.Parent x.Parent=nil else cccon=cccon:Disconnect() end end) end

vrs.addplr=function(plr)
hidden[plr.UserId]={['oldpar']=plr.Character and plr.Character.Parent}
if plr.Character then plr.Character.Parent=nil end
local ccon;ccon=plr.CharacterAdded:Connect(function(ch) if hidden[plr.UserId] then task.defer(vrs.prnil,ch,plr) else ccon=ccon:Disconnect() end end)
if not vrs.rcon then vrs.rcon=funcs.plrs.PlayerRemoving:Connect(function(plrr) if hidden[plrr.UserId] then hidden[plrr.UserId]=nil local n=0 for i,v in next,hidden do n+=1 end if n<=0 then vrs.rcon=vrs.rcon:Disconnect() if ccon then ccon=ccon:Disconnect() end end end end) end plr.Parent=vrs.hiddendeath
end

local plug={["hideplr"]={['desc']="hides arg[1]",['func']=function(n,nn) 
	if nn then for k,v in next,funcs.xgetplr(nn) do if not hidden[v.UserId] then
    vrs.addplr(v)
    end end end
end},
["showplr"]={['desc']="shows players.",['func']=function(n,nn) 
	for i,v in next,vrs.hiddendeath:GetChildren() do if hidden[v.UserId] then
	v.Character.Parent=hidden[v.UserId].oldpar or workspace hidden[v.UserId]=nil v.Parent=funcs.plrs
	end end
end},
['Reservedpluginname']='extra.hide'
}
return plug
