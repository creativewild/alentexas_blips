local initBlips = {}

Citizen.CreateThread(
	function()
		for _, data in pairs(BlipData.blips) do
			local blipId = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, data.x, data.y, data.z)
			SetBlipSprite(blipId, data.sprite, 1);
			if data.color then
				Citizen.InvokeNative(0x662D364ABF16DE2F, blipId, GetHashKey(data.color));
			else 
				Citizen.InvokeNative(0x662D364ABF16DE2F, blipId, GetHashKey(Config.colors.WHITE));
			end
			local varString = CreateVarString(10, 'LITERAL_STRING', data.name);
			Citizen.InvokeNative(0x9CB1A1623062F402, blipId, varString)
			table.insert(initBlips, blipId)
		end
	end
)

AddEventHandler(
	"onResourceStop",
	function(resourceName)
		if resourceName == GetCurrentResourceName() then
			for _, blip in pairs(initBlips) do
				RemoveBlip(blip)
			end
		end
	end
)