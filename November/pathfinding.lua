--[[
    IY Plugin written by tostring, converted to stupid admin
    Stealing credit and or releasing without credit can have consequences
    You are free to edit and release an edited version with credits
	updated by [me]
--]]
local pargs={}
local ps = game:GetService("PathfindingService")
local plrs = game:GetService("Players")
local rs = game:GetService("RunService")
local vectorlist = {}
local pathlist={}
local vectorfolder = Instance.new("Folder",workspace)
vectorfolder.Name=funcs.rndmstr(5,20)
local zerozerozero=Vector3.new(0,0,0)
local function FileReadAllLines(filename)
	local lines = {}
	for line in readfile(filename):gmatch("[^\r\n]+") do
		table.insert(lines,line)
	end
	return lines
end
local function get(ch)
local ff= ch:FindFirstChild("hold") or Instance.new("Folder",ch)
ff.Name="hold"
return ff
end
local function getpath(ch)
pathlist[ch]=pathlist[ch] or ps:CreatePath(pargs)
ch.Destroying:Connect(function()
pathlist[ch]=nil
end)
return pathlist[ch]
end
local function nearestplayer(rp, dist)
	local nearest = nil
	for _,v in next, plrs:GetPlayers() do
		if v ~= funcs.lplr and v.Character then
			if not v.Character:FindFirstChild("HumanoidRootPart") then continue end
			local distance = (v.Character.HumanoidRootPart.Position - rp.Position).Magnitude
			local hum=v.Character:FindFirstChildOfClass("Humanoid")
			if hum and hum.Name~="Woman" and hum.Health > 0 and distance < dist and distance > 0 then
				dist = distance
				nearest = v.Character.HumanoidRootPart
			end
		end
	end
	return nearest, dist
end
local function pathfindpos(pos)
    local waypointparts = get(funcs.lplr.Character)
    local path = getpath(funcs.lplr.Character)
	local hum=funcs.lplr.Character:FindFirstChildOfClass("Humanoid")
	path.Blocked:Connect(function()
		funcs.lplr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
	end)
	path:ComputeAsync(funcs.lplr.Character.HumanoidRootPart.Position, pos)
	if path.Status ~= Enum.PathStatus.Success then
		return false
	end
		local ids=#pathlist+1
		pathlist[math.clamp(ids-1,1,math.huge)]=nil
		pathlist[ids]=true
	local waypoints = path:GetWaypoints()
	for _,waypoint in next, waypoints do
		local part = Instance.new("Part",waypointparts)
		funcs.deb:AddItem(part,75)
		local sha = Instance.new("SphereHandleAdornment",part)
		part.Shape = "Ball"
		part.Material = "Neon"
		part.Size = Vector3.new(1, 1, 1)
		part.Transparency = .8
		part.Color = Color3.fromRGB(0, 255, 255)
		part.Position = waypoint.Position
		part.Anchored = true
		part.CanCollide = false
		sha.Adornee = part
		sha.AlwaysOnTop = true
		sha.ZIndex = 1
		sha.Radius = .5
		sha.Transparency = part.Transparency
		sha.Color3 = part.Color
	end
	for _,waypoint in next, waypoints do
				if not pathlist[ids] then break end
		hum:MoveTo(waypoint.Position)
		if waypoint.Action == Enum.PathWaypointAction.Jump then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
		end
		hum.MoveToFinished:Wait()
	end
	funcs.deb:AddItem(waypointparts,0)
end
local function pathfindlist(list)
	local waypointparts = get(funcs.lplr.Character)
	local vectorpoints = get(funcs.lplr.Character)
	for _,v in next, list do
		local part = Instance.new("Part")
		local split = string.split(v,",")
		part.Shape = "Ball"
		part.Material = "Neon"
		part.Size = Vector3.new(1, 1, 1)
		part.Transparency = .8
		part.Color = Color3.fromRGB(0, 255, 0)
		part.Position = Vector3.new(split[1], split[2], split[3])
		part.Anchored = true
		part.CanCollide = false
		part.Parent = vectorpoints
	end
	for _,v in next, list do
		local split = string.split(v,",")
		local path = getpath(funcs.lplr.Character)
		local hum=funcs.lplr.Character:FindFirstChildOfClass("Humanoid")
		path.Blocked:Connect(function()
			funcs.lplr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
		end)
		path:ComputeAsync(funcs.lplr.Character.HumanoidRootPart.Position, Vector3.new(split[1], split[2], split[3]))
		if path.Status ~= Enum.PathStatus.Success then
			return false
		end
		local ids=#pathlist+1
		pathlist[math.clamp(ids-1,1,math.huge)]=nil
		pathlist[ids]=true
		local waypoints = path:GetWaypoints()
		for _,waypoint in next, waypoints do
			local part = Instance.new("Part",waypointparts)
			local sha = Instance.new("SphereHandleAdornment",part)
			funcs.deb:AddItem(part,75)
			part.Shape = "Ball"
			part.Material = "Neon"
			part.Size = Vector3.new(1, 1, 1)
			part.Transparency = .8
			part.Color = Color3.fromRGB(0, 255, 255)
			part.Position = waypoint.Position
			part.Anchored = true
			part.CanCollide = false
			sha.Adornee = part
			sha.AlwaysOnTop = true
			sha.ZIndex = 1
			sha.Radius = .5
			sha.Transparency = part.Transparency
			sha.Color3 = part.Color
		end
		for _,waypoint in next, waypoints do
					if not pathlist[ids] then break end
			hum:MoveTo(waypoint.Position)
			if waypoint.Action == Enum.PathWaypointAction.Jump then
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end
			hum.MoveToFinished:Wait()
		end
		for _,v in next, waypointparts:GetChildren() do
			v:Destroy()
		end
	end
	funcs.deb:AddItem(vectorpoints,0)
end
local function pathfindtonearestplr(maxdistance,offset,theplr)
	local waypointparts = get(funcs.lplr.Character)
	local near
	local dist
	local offset=zerozerozero
	--print(maxdistance,theplr)
	if theplr~=nil then
	near=theplr.Character:WaitForChild("HumanoidRootPart",10) or theplr.CharacterAdded:Wait():WaitForChild("HumanoidRootPart",10)
	dist = (funcs.lplr.Character:WaitForChild("HumanoidRootPart",10).Position-near.Position).Magnitude
	offset=Vector3.new(0,0,3)
	else
	near, dist = nearestplayer(funcs.lplr.Character.HumanoidRootPart,maxdistance)
	end
	local hum=funcs.lplr.Character:FindFirstChildOfClass("Humanoid")
	if dist > maxdistance and (near.Position.Y - funcs.lplr.Character.HumanoidRootPart.Position.Y) < workspace:CalculateJumpDistance(workspace.Gravity,hum.JumpPower,hum.WalkSpeed) then
	hum:MoveTo(near.CFrame:PointToWorldSpace(offset),near)
	pathlist.currentpath=nil
	return
	end
	if dist < maxdistance then
		local path = getpath(funcs.lplr.Character)
		path.Blocked:Connect(function()
		if not hum.Jump then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)
		path:ComputeAsync(funcs.lplr.Character.HumanoidRootPart.Position, near.CFrame:PointToWorldSpace(offset))
		if path.Status ~= Enum.PathStatus.Success then
			return false
		end
		local waypoints = path:GetWaypoints()
		coroutine.wrap(function()
		for _,waypoint in next, waypoints do
			local part = Instance.new("Part",waypointparts)
			local sha = Instance.new("SphereHandleAdornment",part)
			funcs.deb:AddItem(part,60)
			part.Shape = "Ball"
			part.Material = "Neon"
			part.Size = Vector3.new(1, 1, 1)
			part.Transparency = .8
			part.Color = Color3.fromRGB(0, 255, 255)
			part.Position = waypoint.Position
			part.Anchored = true
			part.CanCollide = false
			sha.Adornee = part
			sha.AlwaysOnTop = true
			sha.ZIndex = 1
			sha.Radius = .5
			sha.Transparency = part.Transparency
			sha.Color3 = part.Color
		end 
		end)()
		local ids=near.Parent.Name..os.clock()
		for _,waypoint in next, waypoints do
			if _==1 then pathlist.currentpath=ids end
			if not pathlist.currentpath==ids then break end
			local th=false
			hum:MoveTo(waypoint.Position)
			local con
			con=hum.MoveToFinished:Connect(function()
			th=true
			con:Disconnect()
			end)
			print(waypoint.Action)
			if not hum.Jump and waypoint.Action == Enum.PathWaypointAction.Jump or near.Position.Y > funcs.lplr.Character.HumanoidRootPart.Position.Y+1 and (near.Position.Y - plr.Character.HumanoidRootPart.Position.Y)  <= workspace:CalculateJumpDistance(workspace.Gravity,hum.JumpPower,hum.WalkSpeed) then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end
			while not th and pathlist.currentpath==ids do task.wait() end
		end
		funcs.deb:AddItem(waypointparts,2)
	end
end

local plug = {--can be used to create paths for a walkbot or walk to paths or nearest player.
		["Reservedpluginname"] = "extra.pfind",
        ["pfnearest"] = {
            ["desc"] = "automatically gets path to nearest player and walks over to them.",
            ["func"] = function(strt,nn)
                pathfindtonearestplr(tonumber(nn) or math.huge,Vector3.new(0,0,tonumber(strt[1]) or 0))
            end
        },
		 ["pfplayer"] = {
            ['desc'] = "automatically gets path to player and walks over to them.",
            ['aliases'] = {["pfplr"]='pfplayer'},
            ['func'] = function(strt,nn)
			local mplr=funcs.xgetplr(nn,true)
			if mplr then
                pathfindtonearestplr(tonumber(strt[2]) or math.huge,Vector3.new(0,0,strt[1] or 6),mplr)
				end
            end
        },
        ["pfpos"] = {
            ['desc'] = "automatically gets path to position and walks to it.",
            ['func'] = function(strt,nn)
                pathfindpos(Vector3.new(tonumber(nn),tonumber(strt[1]),tonumber(strt[2])))
            end
        },
        ["pflist"] = {
            ['desc'] = "automatically follows all the paths inside of the file.",
            ['func'] = function(strt,nn)
                pathfindlist(FileReadAllLines(nn or ''))
            end
        },
        ["markpos"] = {
            ['desc'] = "marks your position and adds it to a table which can saved.",
            ['func'] = function(strt,nn)
                local part = Instance.new("Part",vectorfolder)
                part.Shape = "Ball"
                part.Material = "Neon"
                part.Size = Vector3.new(1, 1, 1)
                part.Transparency = .8
                part.Color = Color3.fromRGB(0, 255, 0)
                part.Position = funcs.lplr.Character.HumanoidRootPart.Position
                part.Anchored = true
                part.CanCollide = false
                table.insert(vectorlist,funcs.lplr.Character.HumanoidRootPart.Position)
            end
        },
        ["savelist"] = {
            ['desc'] = "saves all the positions you have marked into a file.",
            ['func'] = function(strt,nn)
			if not nn then return end
                local combine = ""
                for _,v in next, vectorlist do
                    combine = combine .. tostring(v) .. "\n"
                end
                writefile(nn,combine)
                notify("Pathfinding","List saved to " .. nn)
            end
        },
        ["clearlist"] = {
            ['desc'] = "clears your marked positions so you can start over.",
            ['func'] = function(strt,nn)
                vectorfolder:Destroy()
                vectorfolder = Instance.new("Folder",workspace)
				vectorfolder.Name=funcs.rndmstr(5,20)
                vectorlist = {}
                notify("Pathfinding", "List cleared.")
            end
        }
}

return plug
