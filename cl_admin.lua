local Debugging = false
local Dimensions = {}
local Entity = nil
local HitCoords = vector3(0, 0, 0)
local HitNormal = vector3(0, 0, 0)
local HasFocus = false

function FromRotation(vector)
	local pitch, yaw = (vector.x % 360.0) / 180.0 * math.pi, (vector.z % 360.0) / 180.0 * math.pi

	return vector3(
		math.cos(yaw) * math.cos(pitch),
		math.sin(yaw) * math.cos(pitch),
		math.sin(pitch)
	)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsDisabledControlJustReleased(0, 0x446258B6) then
			Debugging = not Debugging
			print(Debugging)
			ToggleMenu()
		elseif IsDisabledControlJustReleased(0, 0x3C3DD371) then
			ToggleCursor()
		end

		-- Objects.
		local pedCoords = GetEntityCoords(Ped)

		local data = {
			PlayerCoords = nil,
			PlayerCamera = nil,
			PlayerCameraRotation = nil,
			Entity = nil,
			EntityModel = nil,
			EntityMaterial = nil,
			EntityType = nil,
			EntityCoords = nil,
			EntityRotation = nil,
			EntityOwner = nil,
			EntityNetworkID = nil,
			EntityScript = nil,
			EntityHealth = nil,
			HitCoords = nil,
			HitNormal = nil,
		}

		-- Current object.
		local camCoords = GetFinalRenderedCamCoord()
		local camRot = GetFinalRenderedCamRot(0)
		local camForward = FromRotation(camRot + vector3(0, 0, 90))
		local rayTarget = camCoords + camForward * 1000.0
		local rayHandle = StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, rayTarget.x, rayTarget.y, rayTarget.z, -1, Ped, 0)
		local retval, didHit, hitCoords, surfaceNormal, entity = GetShapeTestResult(rayHandle)
		local isEntity = didHit and DoesEntityExist(entity) and GetEntityType(entity) ~= 0

		data.PlayerCoords = "vector4("..pedCoords.x..", "..pedCoords.y..", "..pedCoords.z..", "..GetEntityHeading(Ped)..")"
		data.PlayerCamera = "vector3("..camCoords.x..", "..camCoords.y..", "..camCoords.z..")"
		data.PlayerCameraRotation = "vector3("..camRot.x..", "..camRot.y..", "..camRot.z..")"

		if Entity or didHit then
			if isEntity then
				HitCoords = hitCoords
				HitNormal = surfaceNormal
				Entity = entity
				entityCoords = GetEntityCoords(Entity)
				entityHeading = GetEntityHeading(Entity)
				entityRotation = GetEntityRotation(Entity)

				local netId = 0
				if NetworkGetEntityIsNetworked(Entity) then
					netId = ObjToNet(Entity)
				end

				data.Entity = Entity or 0
				data.EntityModel =  GetEntityModel(Entity)

				data.EntityCoords = "vector4("..entityCoords.x..", "..entityCoords.y..", "..entityCoords.z..", "..entityHeading..")"
				data.EntityRotation = "vector3("..entityRotation.x..", "..entityRotation.y..", "..entityRotation.z..")"

				data.EntityOwner = GetPlayerServerId(NetworkGetEntityOwner(Entity))
				data.EntityNetworkID = netId
				data.EntityHealth = ("%s/%s"):format(GetEntityHealth(Entity), GetEntityMaxHealth(Entity))

				if didHit then
					data.HitCoords = "vector3("..HitCoords.x..", "..HitCoords.y..", "..HitCoords.z..")"
					data.HitNormal = "vector3("..HitNormal.x..", "..HitNormal.y..", "..HitNormal.z..")"
				end
			end
		end

		SendNUIMessage({ info = data })

	end
end)

function ToggleCursor()
	HasFocus = not HasFocus
	SetNuiFocus(HasFocus, HasFocus)
	SetNuiFocusKeepInput(false)
	SetPlayerControl(PlayerPedId(), not HasFocus, 0)
end
RegisterNUICallback("toggleCursor", function(data) ToggleCursor() end)

function ToggleMenu()
	SendNUIMessage( { open = Debugging } )

	if not Debugging and HasFocus then
		ToggleCursor()
	end
end

RegisterNUICallback("toggleMenu", function(data)
	Debugging = not Debugging
	ToggleMenu()
end)
