--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local Box = require(Package.UI.Box)
local Shared = require(Package.UI.Shared)
local Gradient = require(Package.UI.Gradient)
local CornerTypes = require(Package.UI.CornerTypes)
local Stroke = require(Package.UI.Stroke)

local function InventoryBackplate(
	scope: Fusion.Scope,
	props: {
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
		Name = "Inventory",

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

return InventoryBackplate