--Only True Love Is Yandere Love
--In Mighty Flowers Our Poor Hearts Will Bloom
local vrs={['animc']={},['nwc']=game:GetService('NetworkClient'),['chngvhcp']=function(strt,nn,str,cmd,arg) nn=tonumber(nn) if nn then local hum=getchar('Humanoid',true) hum=hum and hum.SeatPart if hum and hum:IsA('VehicleSeat') then hum[arg]=nn end end end}

local cc={
['vhspeed']={['desc']='vehicleular mal- vehicle speed',['func']=vrs.chngvhcp,['args']='MaxSpeed'},
['vhtorque']={['desc']='VEHICULAR MALFUNCTION!!- change vehicle torque (the greater the number, the faster it will reach the maximum speed -roblox)',['func']=vrs.chngvhcp,['args']='Torque'},
['vhsteerp']={['desc']='chng vhcle steerfloat',['func']=vrs.chngvhcp,['args']='SteerFloat'},
['vhturn']={['desc']='description~ being: turn speed vehciluar changing!!',['func']=vrs.chngvhcp,['args']='TurnSpeed'},
['unlockws']={['func']=function(n,nn) nn=nn~=nil for i,v in next,workspace:GetDescendants() do if v:IsA('BasePart') then v.Locked=nn end end end,['desc']='specify arg[1] to lock'},
['datalimit']={['func']=function(n,nn) nn=tonumber(nn) if nn then vrs.nwc:SetOutgoingKBPSLimit(nn) end end,['desc']='SetOutgoingKBPSLimit'},
['danim']={['func']=function(n,nn) 
	 local anims = {
        ["idle"] = 180435571,["idle2"] = 180435792,
        ["walk"] = 180426354,["run"] = 180426354,
        ["jump"] = 125750702,["climb"] = 180436334,
        ["toolnone"] = 182393478,["fall"] = 180436148,
        ["sit"] = 178130996,["dance"] = 182435998,
        ["dance2"] = 182491277,["dance3"] = 182491423
    }
	nn=nn and anims[nn] anims=nil local hum=getchar('Humanoid',true)
    if not (nn and hum) then
      return funcs.sendnotif('noanim',nn,'',4)
    end
    local anim = Instance.new("Animation") anim.AnimationId = "rbxassetid://"..nn for i,v in next,hum:GetPlayingAnimationTracks() do v:Stop() end
	anim=hum:LoadAnimation(anim) anim:Play()
    local ccon=anim:GetPropertyChangedSignal('IsPlaying'):Connect(function()
        if anim.IsPlaying~= true then
            anim:Play();
        end
    end) anim.Destroying:Once(function() ccon:Disconnect() anim:Stop() anim=nil end)  table.insert(vrs.animc,anim)
   end,['desc']='{idle,walk,jump,toolnone,sit,dance2,idle2,run,climb,fall,dance,dance3}-fates'},
 ['undanim']={['func']=function(n,nn) for i,v in next,vrs.animc do funcs.deb:AddItem(v,0) end end},
['Reservedpluginname']='manipulation.manipulation!!'
}

return cc
