--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local Box = require(Package.UI.Box)
local Shared = require(Package.UI.Shared)
local CornerTypes = require(Package.UI.CornerTypes)

local function InventoryPreview(
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

return InventoryPreview