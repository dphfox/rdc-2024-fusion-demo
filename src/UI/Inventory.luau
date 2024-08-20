--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local Box = require(Package.UI.Box)
local Styles = require(Package.UI.Styles)
local TextButton = require(Package.UI.TextButton)

export type Item = {
	Item: Fusion.UsedAs<Items.Item>,
	Amount: Fusion.UsedAs<number>
}

local function Inventory(
	scope: Fusion.Scope<typeof(Fusion)>,
	props: {
		Inventory: {Item},
		DoClose: () -> ()
	}
): Fusion.Child
	scope = scope:innerScope {
		Box = Box,
		TextButton = TextButton
	}

	local selectedSlot = scope:Value(1)
	local selectedItem = scope:Computed(function(use)
		return use(props.Inventory[use(selectedSlot)].Item)
	end)

	local inventorySlots = scope:ForPairs(
		props.Inventory,
		function(
			_,
			scope: Fusion.Scope,
			slotIndex: number,
			inventoryItem: Item
		): (number, Fusion.Child)
			return slotIndex, scope:Box {
				Name = `InventorySlot{slotIndex}`,
				Size = UDim2.fromOffset(64, 64),

				Background = INVENTORY_PALETTE.stroke.light,
				CornerRadius = Styles.corners.mid,
				LayoutOrder = slotIndex,

				OnClick = function()
					if peek(inventoryItem.Amount) > 0 then
						selectedSlot:set(slotIndex)
					end
				end,

				[Children] = {
					scope:Box {
						Name = "Inner",
						Padding = 8,

						[Children] = {
							scope:Box {
								BackgroundTransparency = 0.5,
								ZIndex = 
								Background = INVENTORY_PALETTE.fill.light,
								CornerRadius = UDim.new(1, 0),
							}
						}
					}
				}
			}
		end
	)

	return scope:Box {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(1, -12, 0, 12),
		Size = UDim2.fromOffset(48, 48),

		[Children] = scope:TextButton {
			Text = "X",
			TextSize = Styles.textSize.bigger,
			Palette = Styles.colours.red,
			Size = UDim2.fromOffset(48, 48),
			OnClick = props.OnClick
		}
	}
end

return Inventory