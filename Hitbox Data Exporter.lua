local dlg = Dialog { title = "Hitbox Exporter" }
local filepath = ""
local scriptsFolder = os.getenv('APPDATA') .. "/Aseprite/scripts/"

local spr = app.activeSprite
if not spr then return print "No active sprite" end

local function write_json_data(filename, data)
	local json = dofile(scriptsFolder .. ".utils/json.lua")
	local file = io.open(filename, "w")
	file:write(json.encode(data))
	file:close()
  end

local function getFrameData(layer, from, to)
	local frames = {}

	for i = from, to do								
		local cel = layer:cel(i)

		if cel ~= nil then
			local bounds = { x = cel.bounds.x, y = cel.bounds.y, width = cel.bounds.width, height = cel.bounds.height }
			local frame = { frameIndex =  i - from, bounds = bounds }
			table.insert(frames, frame)			
		end	
	end
	return frames
end

local function exportData()
	if filepath == nil or filepath == "" then
		app.alert("Please choose an output path")
	else
		local data = dlg.data;
		local layers = { }
	
		for i, layer in ipairs(spr.layers) do
			if layer.name == data.hitboxName or layer.name == data.hurtboxName or layer.name == data.pushboxName then				
				local tags = { animationName, frames}
				for j, tag in ipairs(spr.tags) do
					local frameData = getFrameData(layer, tag.fromFrame.frameNumber, tag.toFrame.frameNumber)
					if next(frameData) ~= nil then
						tag = { 
							animationName = tag.name, 
							frames = frameData 
						}
						table.insert(tags, tag)
					end
				end
				layerData = { hitBoxName = layer.name, tagData = tags }
				table.insert(layers, layerData)
			end
		end
		
		write_json_data(filepath, layers)
		app.alert("File exported to " .. filepath)

		dlg:close()
	end
end

dlg:entry { 
	id = "pushboxName",
	label = "Push Box:",
	text = "pushbox"
}

:entry { 
	id = "hitboxName",
	label = "Hit Box:",
	text = "hitbox"
}

:entry { 
	id = "hurtboxName",
	label = "Hurt Box:",
	text = "hurtbox"
}

:file {
	id = "filepath",
	save = true,
	filetypes = {"json"},
	label = "filepath",
	onchange = function()
		filepath = dlg.data["filepath"]
	end
}

:button {
    id = "ok",
    text = "OK",
	onclick = exportData
}

:button {
    id = "cancel",
    text = "Cancel",
    onclick = function()
        dlg:close()
    end
}

dlg:show { wait = false; }