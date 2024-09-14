if not lib then return end

local Items = require 'modules.items.shared' --[[@as table<string, OxClientItem>]]

local function sendDisplayMetadata(data)
    SendNUIMessage({
		action = 'displayMetadata',
		data = data
	})
end

--- use array of single key value pairs to dictate order
---@param metadata string | table<string, string> | table<string, string>[]
---@param value? string
local function displayMetadata(metadata, value)
	local data = {}

	if type(metadata) == 'string' then
        if not value then return end

        data = { { metadata = metadata, value = value } }
	elseif table.type(metadata) == 'array' then
		for i = 1, #metadata do
			for k, v in pairs(metadata[i]) do
				data[i] = {
					metadata = k,
					value = v,
				}
			end
		end
	else
		for k, v in pairs(metadata) do
			data[#data + 1] = {
				metadata = k,
				value = v,
			}
		end
	end

    if client.uiLoaded then
        return sendDisplayMetadata(data)
    end

    CreateThread(function()
        repeat Wait(100) until client.uiLoaded

        sendDisplayMetadata(data)
    end)
end

exports('displayMetadata', displayMetadata)

---@param _ table?
---@param name string?
---@return table?
local function getItem(_, name)
    if not name then return Items end

	if type(name) ~= 'string' then return end

    name = name:lower()

    if name:sub(0, 7) == 'weapon_' then
        name = name:upper()
    end

    return Items[name]
end

setmetatable(Items --[[@as table]], {
	__call = getItem
})

---@cast Items +fun(itemName: string): OxClientItem
---@cast Items +fun(): table<string, OxClientItem>

local function Item(name, cb)
	local item = Items[name]
	if item then
		if not item.client?.export and not item.client?.event then
			item.effect = cb
		end
	end
end

local ox_inventory = exports[shared.resource]
-----------------------------------------------------------------------------------------------
-- Clientside item use functions
-----------------------------------------------------------------------------------------------



Item('bandage', function(data, slot)
	local maxHealth = GetEntityMaxHealth(cache.ped)
	local health = GetEntityHealth(cache.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(cache.ped, math.min(maxHealth, math.floor(health + maxHealth / 16)))
			lib.notify({ description = 'You feel better already' })
		end
	end)
end)

Item('lightarmor', function(data, slot)
    if GetPedArmour(cache.ped) <= 25 then
        ox_inventory:useItem(data, function(data)
            if data then
                SetPlayerMaxArmour(PlayerData.id, 25)
                SetPedArmour(cache.ped, 25)
            end
        end)
    end
end)

Item('armor', function(data, slot)
    if GetPedArmour(cache.ped) <= 50 then
        ox_inventory:useItem(data, function(data)
            if data then
                SetPlayerMaxArmour(PlayerData.id, 50)
                SetPedArmour(cache.ped, 50)
            end
        end)
    end
end)

Item('heavyarmor', function(data, slot)
    if GetPedArmour(cache.ped) <= 75 then
        ox_inventory:useItem(data, function(data)
            if data then
                SetPlayerMaxArmour(PlayerData.id, 75)
                SetPedArmour(cache.ped, 75)
            end
        end)
    end
end)

Item('armorplate', function(data, slot)
	if GetPedArmour(cache.ped) < 100 then
		ox_inventory:useItem(data, function(data)
			if data then
                local getPedArmor = GetPedArmour(cache.ped)
               getPedArmor = getPedArmor + 10 AddArmourToPed(cache.ped, getPedArmor )
			end
		end)
	end
end)

client.parachute = false
Item('parachute', function(data, slot)
	if not client.parachute then
		ox_inventory:useItem(data, function(data)
			if data then
				local chute = `GADGET_PARACHUTE`
				SetPlayerParachuteTintIndex(PlayerData.id, -1)
				GiveWeaponToPed(cache.ped, chute, 0, true, false)
				SetPedGadget(cache.ped, chute, true)
				lib.requestModel(1269906701)
				client.parachute = {CreateParachuteBagObject(cache.ped, true, true), slot?.metadata?.type or -1}
				if slot.metadata.type then
					SetPlayerParachuteTintIndex(PlayerData.id, slot.metadata.type)
				end
			end
		end)
	end
end)

Item('powerbank', function(data, slot)
    ox_inventory:useItem(data, function(data)
        if data then
            if not exports["lb-phone"]:IsCharging() or exports["lb-phone"]:IsPhoneDead() then
                exports["lb-phone"]:ToggleCharging(true)
                BatteryLoop()
                lib.notify({
                    title = 'PHONE CHARGER',
                    description = 'Charging phone',
                    position = 'top',
                    style = {
                        backgroundColor = '#141517',
                        color = '#909296'
                    },
                    icon = 'fa-solid fa-mobile-screen',
                    iconColor = '#4ce074'
                })
            elseif exports["lb-phone"]:IsCharging() then
                lib.notify({
                    title = 'PHONE CHARGER',
                    description = 'Phone Already Charging',
                    position = 'top',
                    style = {
                        backgroundColor = '#141517',
                        color = '#909296'
                    },
                    icon = 'fa-solid fa-mobile-screen',
                    iconColor = 'red'
                })
            elseif exports["lb-phone"]:GetBattery() >= 90 then
                lib.notify({
                    title = 'PHONE CHARGER',
                    description = 'Phone does not need charge yet.',
                    position = 'top',
                    style = {
                        backgroundColor = '#141517',
                        color = '#909296'
                    },
                    icon = 'fa-solid fa-mobile-screen',
                    iconColor = 'red'
                })
            end
        end
    end)
end)

function BatteryLoop()
    if not looped then
        looped = true
        CreateThread(function()
            while true do
                local myPhoneBattery = exports["lb-phone"]:GetBattery()
                Wait(10)
                if myPhoneBattery <= 99 then
                Wait(1000 * 10)
                myPhoneBattery +=1
                exports["lb-phone"]:SetBattery(myPhoneBattery)
                elseif myPhoneBattery >= 99 then
                    exports["lb-phone"]:ToggleCharging(false)
                    lib.notify({
                        title = 'PHONE CHARGER',
                        description = 'Charged',
                        position = 'top',
                        style = {
                            backgroundColor = '#141517',
                            color = '#909296'
                        },
                        icon = 'fa-solid fa-mobile-screen',
                        iconColor = '#4ce074'
                    })
                    looped = false
                    break
                end
            end
        end)
    end
end

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

exports('Items', function(item) return getItem(nil, item) end)
exports('ItemList', function(item) return getItem(nil, item) end)

return Items
