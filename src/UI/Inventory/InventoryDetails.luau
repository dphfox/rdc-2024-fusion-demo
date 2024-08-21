--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local Shared = require(Package.UI.Shared)
local Box = require(Package.UI.Components.Box)
local CornerTypes = require(Package.UI.FX.CornerTypes)

--- The inventory pane housing title, description, and action buttons.
local function InventoryDetails(
	scope: Fusion.Scope,
	props: {}
): Fusion.Child
	local scope = scope:innerScope(CornerTypes, {
		Box = Box
	})

	local palette = Shared.palette:now()

	return scope:Box {
		Name = "Preview",
		LayoutOrder = 1,

		Colour = palette.stroke.light,
		
		[Children] = {
			scope:CornersMid()
		}
	}
end

return InventoryDetails