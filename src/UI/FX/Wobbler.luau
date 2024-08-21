--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local peek = Fusion.peek

--- Utility for creating wobbles in response to an event.
local function Wobbler<Type, RespondTo>(
	scope: Fusion.Scope,
	props: {
		RestAt: Type,
		WobbleVelocity: Type,
		SpringSpeed: number,
		SpringDamping: number,

		RespondTo: Fusion.UsedAs<RespondTo>,
		ResponseType: "always" | "whenTruthy"
	}
)
	local wobbler = scope:Spring(
		scope:Value(props.RestAt),
		props.SpringSpeed,
		props.SpringDamping
	)

	scope:Observer(props.RespondTo):onChange(function()
		local value = peek(props.RespondTo)
		local shouldRespond = 
			if props.ResponseType == "always" then
				true
			elseif props.ResponseType == "whenTruthy" then
				not not value
			else
				error("Invalid response type")

		if shouldRespond then
			wobbler:setVelocity(props.WobbleVelocity)
		end
	end)

	return wobbler
end

return Wobbler