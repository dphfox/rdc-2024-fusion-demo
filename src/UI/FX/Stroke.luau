--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local Gradient = require(Package.UI.FX.Gradient)

-- A thick stroke with configurable gradient colours.
local function Stroke(
	scope: Fusion.Scope,
	props: {
		Mode: Enum.ApplyStrokeMode,
		Top: Fusion.UsedAs<Color3>,
		Bottom: Fusion.UsedAs<Color3>,
	}
): Fusion.Child
	local scope = scope:innerScope {
		Gradient = Gradient
	}
	return scope:New "UIStroke" {
		ApplyStrokeMode = props.Mode,
		Color = Color3.new(1, 1, 1),
		Thickness = 4,

		[Children] = scope:Gradient {
			Top = props.Top,
			Bottom = props.Bottom
		}
	}
end

return Stroke