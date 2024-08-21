--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children

local Items = require(ReplicatedStorage.Data.Items)

local Shared = require(ReplicatedStorage.UI.Shared)
local Styles = require(ReplicatedStorage.UI.Styles)
local Box = require(ReplicatedStorage.UI.Components.Box)
local Text = require(ReplicatedStorage.UI.Components.Text)
local CornerTypes = require(ReplicatedStorage.UI.FX.CornerTypes)
local Wobbler = require(ReplicatedStorage.UI.FX.Wobbler)

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
		Box = Box,
		Text = Text,
		Wobbler = Wobbler
	})

	local palette = Shared.palette:now()

	local hasItem = scope:Computed(function(use)
		return use(props.Data.Amount) > 0 and use(props.Data.Item) ~= nil
	end)

	local isHovering = scope:Value(false)
	local isPressing = scope:Value(false)

	return scope:Box {
		Name = `Slot {props.Index}`,

		Colour = palette.stroke.light,
		LayoutOrder = props.Index,

		OnActivated = props.OnActivated,

		OnHoverStart = function()
			isHovering:set(true)
		end,
		OnHoverEnd = function()
			isHovering:set(false)
		end,
		OnPressStart = function()
			isPressing:set(true)
		end,
		OnPressEnd = function()
			isPressing:set(false)
		end,

		[Children] = {
			scope:CornersMid(),
			scope:Box {
				Name = "Inner",

				[Children] = Fusion.Child {
					scope:New "ImageLabel" {
						Name = "Item Image",

						BackgroundTransparency = 1,
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = scope:Spring(scope:Computed(function(use)
							if use(isPressing) then
								return UDim2.new(1, -32, 1, -32)
							elseif use(isHovering) then
								return UDim2.new(1, -8, 1, -8)
							else
								return UDim2.new(1, -16, 1, -16)
							end
						end), 50),

						Image = scope:Computed(function(use)
							local item = use(props.Data.Item)
							if item == nil then
								return ""
							else
								return item.icon
							end
						end)
					},
					scope:Box {
						Name = "Quantity Label",

						Position = UDim2.new(1, -16, 1, -8),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.fromOffset(40, 20),

						Rotation = scope:Wobbler {
							RestAt = -15,
							WobbleVelocity = 1000,
							SpringSpeed = 20,
							SpringDamping = 0.5,
							RespondTo = props.Selected,
							ResponseType = "whenTruthy"
						},

						Visible = hasItem,

						Colour = scope:Spring(scope:Computed(function(use)
							return if use(props.Selected) then palette.fill.light else palette.text
						end), 50),

						[Children] = {
							scope:CornersFull(),

							scope:Text {
								Position = UDim2.fromScale(0.5, 0.5),
								AnchorPoint = Vector2.new(0.5, 0.5),

								Text = scope:Computed(function(use)
									return `x{use(props.Data.Amount)}`
								end),
								Font = Styles.fonts.body,
								TextSize = Styles.textSizes.tooltip,
								TextColour = scope:Spring(scope:Computed(function(use)
									return if use(props.Selected) then palette.text else palette.fill.light
								end), 50)
							}
						}
					},
					scope:Box {
						Name = "Selection Circle",

						Transparency = scope:Spring(scope:Computed(function(use)
							return if use(props.Selected) then 0.5 else 1
						end), 50),
						ZIndex = -1,
						Colour = palette.fill.light,

						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = scope:Spring(scope:Computed(function(use)
							if use(props.Selected) then 
								return UDim2.new(1, -8, 1, -8)
							else
								return UDim2.new(1, -32, 1, -32)
							end
						end), 50),

						[Children] = scope:CornersFull()
					}
				}
			}
		}
	}
end

return InventorySlot