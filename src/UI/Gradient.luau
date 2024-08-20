--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)

local function Gradient(
	scope: Fusion.Scope,
	props: {
		Top: Fusion.UsedAs<Color3>,
		Bottom: Fusion.UsedAs<Color3>,
	}
): Fusion.Child
	return scope:New "UIGradient" {
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