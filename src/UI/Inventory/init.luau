--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local peek = Fusion.peek
local Children = Fusion.Children

local Items = require(Package.Data.Items)

local Shared = require(Package.UI.Shared)
local Styles = require(Package.UI.Styles)
local Box = require(Package.UI.Components.Box)
local CloseButton = require(Package.UI.Components.CloseButton)
local Window = require(Package.UI.Components.Window)
local CornerTypes = require(Package.UI.FX.CornerTypes)
local InventoryLayout = require(Package.UI.Inventory.InventoryLayout)
local InventorySlot = require(Package.UI.Inventory.InventorySlot)
local InventoryPreview = require(Package.UI.Inventory.InventoryPreview)
local InventoryDetails = require(Package.UI.Inventory.InventoryDetails)

export type SlotData = {
	Item: Fusion.UsedAs<Items.Item>,
	Amount: Fusion.UsedAs<number>
}

local INVENTORY_SLOTS = 16

local function Inventory(
	scope: Fusion.Scope,
	props: {
		Slots: {SlotData},
		DoClose: () -> ()
	}
): Fusion.Child
	assert(#props.Slots == INVENTORY_SLOTS, "Incorrect number of inventory slots provided")

	local scope = scope:innerScope(CornerTypes, {
		Box = Box,
		CloseButton = CloseButton,
		Window = Window,

		InventoryLayout = InventoryLayout,
		InventorySlot = InventorySlot,
		InventoryPreview = InventoryPreview,
		InventoryDetails = InventoryDetails
	})

	local selectedSlot = scope:Value(1)
	local _selectedItem = scope:Computed(function(use)
		return use(props.Slots[use(selectedSlot)].Item)
	end)

	return 
		Shared.palette
		:is(Styles.colours.yellow)
		:during(function()
			return scope:Window {
				[Children] = {
					scope:CloseButton {
						Position = UDim2.new(1, -12, 0, 12),
						AnchorPoint = Vector2.new(0.5, 0.5),
		
						OnActivated = props.DoClose
					},
		
					-- scope:Title {
					-- 	Position = UDim2.new(0.5, 0, 0, 12),
					-- 	AnchorPoint = Vector2.new(0.5, 0.5),
		
					-- 	Text = "Inventory"
					-- },
		
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
		
							Preview = scope:InventoryPreview {},
							
							Details = scope:InventoryDetails {},
						}
					}
				}
			}
		end)
end

return Inventory