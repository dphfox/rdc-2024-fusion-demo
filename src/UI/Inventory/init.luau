--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local peek = Fusion.peek
local Children = Fusion.Children

local Items = require(ReplicatedStorage.Data.Items)

local Shared = require(ReplicatedStorage.UI.Shared)
local Styles = require(ReplicatedStorage.UI.Styles)
local Box = require(ReplicatedStorage.UI.Components.Box)
local Title = require(ReplicatedStorage.UI.Components.Title)
local CloseButton = require(ReplicatedStorage.UI.Components.CloseButton)
local Window = require(ReplicatedStorage.UI.Components.Window)
local CornerTypes = require(ReplicatedStorage.UI.FX.CornerTypes)
local InventoryLayout = require(ReplicatedStorage.UI.Inventory.InventoryLayout)
local InventorySlot = require(ReplicatedStorage.UI.Inventory.InventorySlot)
local InventoryPreview = require(ReplicatedStorage.UI.Inventory.InventoryPreview)
local InventoryDetails = require(ReplicatedStorage.UI.Inventory.InventoryDetails)

export type SlotData = {
	Item: Fusion.UsedAs<Items.Item?>,
	Amount: Fusion.UsedAs<number>
}

--- The main inventory window.
local function Inventory(
	scope: Fusion.Scope,
	props: {
		Visible: Fusion.UsedAs<boolean>,
		Slots: {SlotData},
		DoClose: () -> ()
	}
): Fusion.Child
	assert(#props.Slots == Shared.INVENTORY_SLOTS, "Incorrect number of inventory slots provided")

	local scope = scope:innerScope(CornerTypes, {
		Box = Box,
		CloseButton = CloseButton,
		Window = Window,
		Title = Title,

		InventoryLayout = InventoryLayout,
		InventorySlot = InventorySlot,
		InventoryPreview = InventoryPreview,
		InventoryDetails = InventoryDetails
	})

	local selectedSlot = scope:Value(1)
	local selectedItem = scope:Computed(function(use)
		return use(props.Slots[use(selectedSlot)].Item)
	end)

	return 
		Shared.palette
		:is(Styles.colours.yellow)
		:during(function()
			return scope:Window {
				Visible = props.Visible,
				[Children] = {
					scope:CloseButton {
						Position = UDim2.new(1, -6, 0, 6),
						AnchorPoint = Vector2.new(0.5, 0.5),
		
						OnActivated = props.DoClose
					},
		
					scope:Title {
						Position = UDim2.new(0.5, 0, 0, 12),
						AnchorPoint = Vector2.new(0.5, 0.5),
		
						Text = "Inventory"
					},
		
					scope:Box {
						Name = "Contents",
						
						Position = UDim2.new(0.5, 0, 1, -16),
						AnchorPoint = Vector2.new(0.5, 1),
						Size = UDim2.new(1, -32, 1, -66),
		
						[Children] = scope:InventoryLayout {
							Slots = scope:ForPairs(
								props.Slots,
								function(_, scope: typeof(scope), index, data)
									return index, scope:InventorySlot {
										Index = index,
										Data = data,
										Selected = scope:Computed(function(use)
											return use(selectedSlot) == index
										end),
		
										OnActivated = function()
											if peek(data.Amount) > 0 then
												selectedSlot:set(index)
											end
										end
									}
								end
							),
		
							Preview = scope:InventoryPreview {
								ActiveItem = selectedItem
							},
							
							Details = scope:InventoryDetails {
								ActiveItem = selectedItem
							},
						}
					}
				}
			}
		end)
end

return Inventory