local pind={["base"]={
["avatar-edit"]={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/avatar_edit.lua',"2/avatar editing cmds"};
["char-manip"]={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/char-manip.lua',"character manipulation/float,noclip,god,reset,dreset,etc."};
["toolthing"]={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/toolthing.lua',"Z - kidnap M - hell N - Void B - Refresh/refresh,gtool,void,etc"};
["tp-cmds"]={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/tp_cmds.lua',"teleport commands/goto/to/lgoto"};
["plugstore"]={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/plugstore.lua',"plug store"};
["uncat"]={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/uncat.lua',"general uncatagorized cmds"};
["diedtp"]={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/diedtp.lua'};
['stupidesp']={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/esp.lua'}
};
['extra']={['glue']={'https://github.com/6yNuiC9/scr/blob/main/newuserdplugins/glue.lua',"glue urself 2 stuff/glue,unglue,gluemsize,gluenoclip,gluedes"},['autoupdate']={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/autoupdate.lua'},["icepoolshook"]={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/icepoolshook.lua',"game specific commands, makes hughjazz be a hub."},
['hide']={'https://github.com/6yNuiC9/scr/raw/main/newuserdplugins/hide.lua',"2/hide players/hideplr,showplr"}
};
['extra.bad']={['pathfinding']={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/pathfinding.lua',"7/IY plugin by tostring, updated, improved & converted/pfplayer,pfpos,pfnearest,markpos,etc"}
},
["test"]={["ex"]={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/example.lua',"example"}
};
["th"]={['rv']={'https://raw.githubusercontent.com/6yNuiC9/scr/main/newuserdplugins/rv-theme.lua'}
};
['staging']={['manip']={'https://github.com/6yNuiC9/scr/raw/main/newuserdplugins/manip.lua'}
}

}
local plugss={
Init=function(err,ldplug,gui)
local plug={}
plug.pstore={func=function(strt,parg) 
local tx={}
for i,v in pairs(pind) do
for n,x in pairs(v) do
table.insert(tx,i.."/"..n.."/"..(x[2] or ''))
end
end
gui.txt2.Text=table.concat(tx,"\n\n")
gui._close.Active = true
gui.cmdframe.Active = true
gui._close.Visible = true
gui.cmdframe.Visible = true
gui.txt2.Visible=true gui.txt2.Active=true gui.txt.Active=false gui.txt.Visible=false
if parg~="nn" then funcs.sendnotif("cmds/pstore","waaaa","rbxassetid://8119590978",5) end
end,desc="lists plugs"}

plug.padd={func=function(strt,plrarg,str)
if not strt[1] or not plrarg or not pind[plrarg] or not pind[plrarg][strt[1]] then funcs.sendnotif("cmds/padd/failed","exact plug not found","",5) end
ldplug(loadstring(game:HttpGet(pind[plrarg][strt[1]][1])))
funcs.sendnotif("loaded/plrarg/"..strt[1],"loaded",5)
end,desc="adds plug from store: padd base toolthing"}

plug.psave={func=function(strt,plrarg,str)
if not strt[1] or not plrarg or not pind[plrarg] or not pind[plrarg][strt[1]] then funcs.sendnotif("cmds/psave/failed","exact plug not found","",5) end
if not isfolder("November") then makefolder("November") end
local plug=game:HttpGet(pind[plrarg][strt[1]][1])
writefile("November\\"..strt[1]..".lua",plug)
ldplug(loadstring(plug))
funcs.sendnotif("loaded/plrarg/"..strt[1],"loaded",5)
end,desc="saves plug from store: psave base plugstore"}
plug.Reservedpluginname="base.plug-store" --a

plug.pgsave={['func']=function(strd,pa)

if pind[pa] then if not isfolder("November") then makefolder("November") end 
for x,y in pairs(pind[pa]) do 
local plugs,plugd=pcall(game.HttpGet,game,type(y)=='table' and y[1] or y)
if plugs and plugd then writefile("November\\"..x..".lua",plugd) end task.wait(.4)
end end
funcs.sendnotif('pstore',pind[pa] and 'saved as many as possible' or 'plug-group not found','',5)
end;['desc']='save an entire plugin group, does not load them in'}

return plug
end
}
return plugss
