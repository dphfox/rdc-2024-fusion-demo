--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)

-- A matte vertical gradient with tweakable top and bottom colours.
local function Gradient(
	scope: Fusion.Scope,
	props: {
		Top: Fusion.UsedAs<Color3>,
		Bottom: Fusion.UsedAs<Color3>,
	}
): Fusion.Child
	return scope:New "UIGradient" {
		Name = "Gradient",
		Color = scope:Computed(function(use)
			return ColorSequence.new(
				use(props.Top),
				use(props.Bottom)
			)
		end),
		Rotation = 90
	}
end

return Gradient