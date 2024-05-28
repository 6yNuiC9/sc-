local function setatr(inst,props)
for y,x in next,inst do
for i,v in next,props do
x:SetAttribute(v,x[v])
end
end
end
powersupply.gnn._txtbox.BackgroundColor3=Color3.fromRGB(76, 25, 25)
powersupply.gnn.cmdframe.BackgroundColor3=Color3.fromRGB(17,0,0)
powersupply.gnn.cmdframe.BorderColor3=Color3.fromRGB(100,0,0)
powersupply.gnn._close.BorderColor3=Color3.fromRGB(100,0,0)
powersupply.gnn._close.BackgroundColor3=Color3.fromRGB(17,0,0)

setatr({powersupply.gnn._close,powersupply.gnn.cmdframe,powersupply.gnn._txtbox},{'BorderColor','BorderColor3','BackgroundColor3','BackgroundColor'})
setatr=nil
