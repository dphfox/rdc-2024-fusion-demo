--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children
local Out = Fusion.Out

local Items = require(ReplicatedStorage.Data.Items)

local Shared = require(ReplicatedStorage.UI.Shared)
local Styles = require(ReplicatedStorage.UI.Styles)
local Box = require(ReplicatedStorage.UI.Components.Box)
local Button = require(ReplicatedStorage.UI.Components.Button)
local Text = require(ReplicatedStorage.UI.Components.Text)
local CornerTypes = require(ReplicatedStorage.UI.FX.CornerTypes)

--- The inventory pane housing title, description, and action buttons.
local function InventoryDetails(
	scope: Fusion.Scope,
	props: {
		ActiveItem: Fusion.UsedAs<Items.Item?>
	}
): Fusion.Child
	local scope = scope:innerScope(CornerTypes, {
		Box = Box,
		Button = Button,
		Text = Text
	})

	local detailsBoxSize = scope:Value(Vector2.zero)
	local actionRowSize = scope:Value(Vector2.zero)

	return scope:Box {
		Name = "Details",
		OutSize = detailsBoxSize,
		
		[Children] = Fusion.Child {
			scope:New "UIListLayout" {
				Name = "Vertical Layout",
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, 8)
			},

			scope:Box {
				LayoutOrder = 1,
				Name = "Paragraph Area",
				Size = UDim2.fromScale(1, 0),

				[Children] = Fusion.Child {
					scope:New "UIListLayout" {
						Name = "Vertical Layout",
						SortOrder = Enum.SortOrder.LayoutOrder,
						FillDirection = Enum.FillDirection.Vertical,
						Padding = UDim.new(0, 4)
					},

					scope:New "UIFlexItem" {
						Name = "Grow to Fill",
						FlexMode = Enum.UIFlexMode.Fill
					},

					scope:Text {
						LayoutOrder = 1,
						Text = scope:Computed(function(use)
							local item = use(props.ActiveItem)
							if item == nil then
								return ""
							else
								return item.name
							end
						end),
						TextSize = Styles.textSizes.header,
						Font = Styles.fonts.title
					},
		
					scope:Text {
						LayoutOrder = 2,
						Text = scope:Computed(function(use)
							local item = use(props.ActiveItem)
							if item == nil then
								return ""
							else
								return item.description
							end
						end),
						TextSize = Styles.textSizes.body,
						Font = Styles.fonts.body,

						WrapBounds = detailsBoxSize,
						AlignX = Enum.TextXAlignment.Left,
						AlignY = Enum.TextYAlignment.Top
					},
				}
			},

			scope:Box {
				LayoutOrder = 2,
				Name = "Action Row",

				Size = scope:Computed(function(use)
					local size = use(actionRowSize)
					return UDim2.fromOffset(size.X, size.Y + 4)
				end),

				[Children] = Fusion.Child {
					scope:New "UIListLayout" {
						Name = "Horizontal Layout",
						SortOrder = Enum.SortOrder.LayoutOrder,
						FillDirection = Enum.FillDirection.Horizontal,
						Padding = UDim.new(0, 20),
						[Out "AbsoluteContentSize"] = actionRowSize
					},

					Shared.palette
					:is(Styles.colours.green)
					:during(function()
						return scope:Button {
							LayoutOrder = 1,
							Text = "Plant"
						}
					end),

					Shared.palette
					:is(Styles.colours.platinum)
					:during(function()
						return {
							scope:Button {
								LayoutOrder = 2,
								Text = "Give"
							},
		
							scope:Button {
								LayoutOrder = 3,
								Text = "Throw"
							}
						}
					end)
				}
			}
		}
	}
end

return InventoryDetails