--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local function Stroke(
	scope: Fusion.Scope<typeof(Fusion)>,
	props: {
		Mode: Enum.ApplyStrokeMode,
		Top: Fusion.UsedAs<Color3>,
		Bottom: Fusion.UsedAs<Color3>,
	}
): Fusion.Child
	return scope:New "UIStroke" {
		ApplyStrokeMode = props.Mode,
		Color = Color3.new(1, 1, 1),
		Thickness = 4,

		[Children] = scope:New "UIGradient" {
			Color = scope:Computed(function(use)
				return ColorSequence.new(
					use(props.Top),
					use(props.Bottom)
				)
			end),
			Rotation = 90
		}
	}
end

return Stroke