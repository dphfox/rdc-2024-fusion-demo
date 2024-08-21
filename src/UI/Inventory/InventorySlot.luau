--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children

local Items = require(ReplicatedStorage.Data.Items)

local Shared = require(ReplicatedStorage.UI.Shared)
local Box = require(ReplicatedStorage.UI.Components.Box)
local CornerTypes = require(ReplicatedStorage.UI.FX.CornerTypes)

export type SlotData = {
	Item: Fusion.UsedAs<Items.Item?>,
	Amount: Fusion.UsedAs<number>
}

--- A single item slot from the top half of the inventory window.
local function InventorySlot(
	scope: Fusion.Scope,
	props: {
		Index: number,
		Data: SlotData,
		Selected: Fusion.UsedAs<boolean>,

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
			scope:CornersMid(),
			scope:Box {
				Name = "Inner",
				Padding = 8,

				[Children] = {

					scope:Box {
						Transparency = 0.5,
						ZIndex = -1,
						Colour = palette.fill.light,
						Visible = props.Selected,

						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.new(1, -8, 1, -8),

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