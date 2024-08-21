--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children

local Box = require(ReplicatedStorage.UI.Components.Box)

--- Creates some panes in a three-way layout, with `Slots` across the top,
--- `Preview` as a square in the bottom-left, and `Details` filling out the rest
--- of the space in the bottom-right.
local function InventoryLayout(
	scope: Fusion.Scope,
	props: {
		Slots: Fusion.Child,
		Preview: Fusion.Child,
		Details: Fusion.Child
	}
): Fusion.Child
	local scope = scope:innerScope {
		Box = Box
	}

	return Fusion.Child {
		scope:New "UIListLayout" {
			Name = "Vertical Layout",
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 32)
		},

		scope:Box {
			Name = "Slots Area",
			LayoutOrder = 1,

			[Children] = Fusion.Child {
				scope:New "UIFlexItem" {
					Name = "Shrink To Fit",
					FlexMode = Enum.UIFlexMode.Shrink
				},

				scope:New "UIGridLayout" {
					Name = "Slot Grid",
					SortOrder = Enum.SortOrder.LayoutOrder,
					CellSize = UDim2.fromOffset(64, 64),
					CellPadding = UDim2.fromOffset(8, 8),
					FillDirection = Enum.FillDirection.Horizontal,
				},

				props.Slots
			}
		},

		scope:Box {
			Name = "Bottom Area",
			LayoutOrder = 2,

			Size = UDim2.new(1, 0, 0, 128),

			[Children] = Fusion.Child {
				scope:New "UIListLayout" {
					Name = "Horizontal Layout",
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 16),
					FillDirection = Enum.FillDirection.Horizontal
				},

				scope:Box {
					Name = "Preview Area",
					LayoutOrder = 1,
					
					[Children] = Fusion.Child {
						scope:New "UIAspectRatioConstraint" {
							Name = "Keep Square"
						},

						props.Preview
					}
				},

				scope:Box {
					Name = "Details Area",
					LayoutOrder = 2,

					[Children] = Fusion.Child {
						scope:New "UIFlexItem" {
							Name = "Grow to Fill",
							FlexMode = Enum.UIFlexMode.Fill
						},

						props.Details
					}
				}
			}
		}
	}
end

return InventoryLayout