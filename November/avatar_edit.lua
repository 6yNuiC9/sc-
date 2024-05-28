local avs=game:GetService("AvatarEditorService")
local function settype(strd,plrarg,x,cmd)
local hn=funcs.plrs:GetHumanoidDescriptionFromUserId(funcs.lplr.UserId)
avs:PromptSaveAvatar(hn,Enum.HumanoidRigType[string.upper(cmd)])
funcs.deb:AddItem(hn,0)
end
local plug={
["r6"]={['func']=settype};
['Reservedpluginname']="base.avatar_edit"
}
plug.r15=plug.r6
return plug
