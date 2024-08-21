--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children

local Shared = require(ReplicatedStorage.UI.Shared)
local Box = require(ReplicatedStorage.UI.Components.Box)
local CornerTypes = require(ReplicatedStorage.UI.FX.CornerTypes)

--- The square preview box in the bottom-left of the inventory window.
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