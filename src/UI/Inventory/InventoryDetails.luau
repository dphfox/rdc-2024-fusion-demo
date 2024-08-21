--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children

local Shared = require(ReplicatedStorage.UI.Shared)
local Box = require(ReplicatedStorage.UI.Components.Box)
local CornerTypes = require(ReplicatedStorage.UI.FX.CornerTypes)

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
		Name = "Details",
		LayoutOrder = 1,
		
		[Children] = {
			
		}
	}
end

return InventoryDetails