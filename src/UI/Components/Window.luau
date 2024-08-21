--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local Shared = require(Package.UI.Shared)
local Box = require(Package.UI.Components.Box)
local Gradient = require(Package.UI.FX.Gradient)
local CornerTypes = require(Package.UI.FX.CornerTypes)
local Stroke = require(Package.UI.FX.Stroke)

--- A large, centred rectangular box that adopts the current colour palette.
local function Window(
	scope: Fusion.Scope,
	props: {
		Name: Fusion.UsedAs<string>?,
		[typeof(Children)]: Fusion.Child
	}
): Fusion.Child
	local scope = scope:innerScope(CornerTypes, {
		Box = Box,
		Gradient = Gradient,
		Stroke = Stroke
	})

	local palette = Shared.palette:now()

	return scope:Box {
		Name = props.Name or "Window",

		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(600, 362),

		Colour = Color3.new(1, 1, 1),

		[Children] = {
			scope:CornersLarge(),

			scope:Gradient {
				Top = palette.fill.mid,
				Bottom = palette.fill.dark
			},

			scope:Stroke {
				Mode = Enum.ApplyStrokeMode.Border,
				Top = palette.fill.mid,
				Bottom = palette.fill.dark
			},

			props[Children]
		}
	}
end

return Window