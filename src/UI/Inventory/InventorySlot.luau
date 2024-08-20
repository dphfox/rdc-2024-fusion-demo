--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local Items = require(Package.Data.Items)

local Box = require(Package.UI.Box)
local Shared = require(Package.UI.Shared)
local CornerTypes = require(Package.UI.CornerTypes)

export type SlotData = {
	Item: Fusion.UsedAs<Items.Item>,
	Amount: Fusion.UsedAs<number>
}

local function InventorySlot(
	scope: Fusion.Scope,
	props: {
		Index: number,
		Data: SlotData,

		OnActivated: () -> ()
	}
): Fusion.Child
	local scope = scope:innerScope(CornerTypes, {
		Box = Box
	})

	local palette = Shared.palette:now()

	return scope:Box {
		Name = `Inventory slot {props.Index}`,

		Colour = palette.stroke.light,
		LayoutOrder = props.Index,

		OnActivated = props.OnActivated,

		[Children] = {
			scope:Box {
				Name = "Inner",
				Padding = 8,

				[Children] = {
					scope:Box {
						BackgroundTransparency = 0.5,
						ZIndex = error("TODO: not implemented"),
						Colour = palette.fill.light,

						[Children] = {
							scope:CornersFull()
						}
					}
				}
			}
		}
	}
end

return InventorySlot