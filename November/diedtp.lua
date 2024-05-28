local vars={}
vars.funcs={}
vars.funcs.dd=function()
local piv=funcs.lplr.Character and funcs.lplr.Character:GetPivot()
if piv then vars.diedc=piv end
end
vars.funcs.os=function(ch)
local hmnoid=funcs.wfcofclass(ch,'Humanoid',20)
if vars.alwayswatching and vars.diedc then ch:PivotTo(vars.diedc) end
if hmnoid then hmnoid.Died:Connect(vars.funcs.dd) end
end
vars.funcs.os(getchar())
funcs.lplr.CharacterAdded:Connect(vars.funcs.os)

local plug={
['diedtp']={['func']=function() if vars.diedc then getchar():PivotTo(vars.diedc) end end;['desc']='go back where you last hmnoid.Died at (ripbozo)'};
['alwayswatching']={['func']=function() vars.alwayswatching=not vars.alwayswatching funcs.sendnotif('diedtp\\alwayswatching',vars.alwayswatching and 'alwayswatching' or 'cringe ahh mfer aint see shit','',5) end;['desc']='always go back where you died?'}
}
return plug
