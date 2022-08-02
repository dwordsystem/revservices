local Services = {
	Functions = {};	
	Players = game:GetService("Players");
	Lighting = game:GetService("Lighting");
	RunService = game:GetService("RunService");
	ReplicatedStorage = game:GetService("ReplicatedStorage");
	TweenService = game:GetService("TweenService");
	UserInputService = game:GetService("UserInputService");
};

Services.Functions.Get = function(path:Instance)
	return game:GetService(path);
end;

Services.Functions.Functions.GetPlayers = function()
	return game:GetService("Players"):GetPlayers();
end;

Services.Functions.Tween = function(item:Instance, options)
	if type(options) ~= "table" then
		if typeof(item) ~= "Instance" then assert(typeof(item)=="table", "Wrong instance input!") end;
		options.TweenInfo = TweenInfo.new(0.5);
		options.Goal = {Transparency = 1};
	end;
	
	spawn(function()
		Services.TweenService:Create(item, options.TweenInfo, options.Goal);
	end);
end

Services.Functions.EditProperty = function(path:Instance, property, value:any)
	coroutine.wrap(function()
		path[property] = value;
	end);
end;

Services.Functions.RunServiceLoop = function(selection:string, callback)
	if type(selection) ~= "string" then 
		selection = "BindToRenderStep";
	end;
	if type(callback) ~= "function" then
		assert(type(callback)=="function", "Wrong callback!");
	end;
	
	if selection == "BindToRenderStep" then
		Services.RunService:BindToRenderStep(math.random(1, 99999), 0, callback);
	elseif selection == "RenderStepped" then
		Services.RunService.RenderStepped:Connect(callback);
	elseif selection == "Heartbeat" then
		Services.RunService.Heartbeat:Connect(callback);
	elseif selection == "Stepped" then
		Services.RunService.Stepped:Connect(callback);
	end;
end;

return Services;
