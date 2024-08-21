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
local Wobbler = require(ReplicatedStorage.UI.FX.Wobbler)

--- The square preview box in the bottom-left of the inventory window.
local function InventoryPreview(
	scope: Fusion.Scope,
	props: {
		ActiveItem: Fusion.UsedAs<Items.Item?>
	}
): Fusion.Child
	local scope = scope:innerScope(CornerTypes, {
		Box = Box,
		Wobbler = Wobbler
	})

	local palette = Shared.palette:now()

	local previewScale = scope:Wobbler {
		RestAt = 0.75,
		WobbleVelocity = 5,
		SpringSpeed = 20,
		SpringDamping = 0.5,
		RespondTo = props.ActiveItem,
		ResponseType = "always"
	}

	return scope:Box {
		Name = "Preview",
		LayoutOrder = 1,

		Colour = palette.stroke.light,
		
		[Children] = {
			scope:CornersMid(),

			scope:New "ImageLabel" {
				Name = "Item Image",

				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = scope:Computed(function(use)
					local scale = use(previewScale)
					return UDim2.fromScale(scale, scale)
				end),

				Image = scope:Computed(function(use)
					local item = use(props.ActiveItem)
					if item == nil then
						return ""
					else
						return item.icon
					end
				end)
			},
		}
	}
end

return InventoryPreview