--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stories = script.Parent

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children
local peek = Fusion.peek

local Items = require(ReplicatedStorage.Data.Items)

local Shared = require(ReplicatedStorage.UI.Shared)
local Button = require(ReplicatedStorage.UI.Components.Button)
local Inventory = require(ReplicatedStorage.UI.Inventory)
local StoryFrame = require(Stories.Components.StoryFrame)

return function(
	parent: Instance
): () -> ()

	local scope = Fusion:scoped {
		Button = Button,
		Inventory = Inventory,
		StoryFrame = StoryFrame
	}

	local visible = scope:Value(true)

	local slots = {}
	for index = 1, Shared.INVENTORY_SLOTS do
		slots[index] = {
			Item = scope:Value(nil),
			Amount = scope:Value(0)
		}
	end

	slots[1].Item:set(Items.pepper)
	slots[1].Amount:set(36)

	slots[2].Item:set(Items.watermelon)
	slots[2].Amount:set(24)

	slots[3].Item:set(Items.strawberry)
	slots[3].Amount:set(12)

	slots[4].Item:set(Items.tomato)
	slots[4].Amount:set(6)

	scope:StoryFrame {
		Parent = parent,
		[Children] = {
			scope:Button {
				Text = "Toggle visibility",
				Position = UDim2.new(0.5, 0, 0, 12),
				AnchorPoint = Vector2.new(0.5, 0),

				OnActivated = function()
					visible:set(not peek(visible))
				end
			},

			scope:Inventory {
				Visible = visible,
				Slots = slots,
				DoClose = function()
					visible:set(false)
				end,
				DoPlant = function(slotIndex)
					print(`Planting item from slot {slotIndex}`)
				end,
				DoGive = function(slotIndex)
					print(`Giving item from slot {slotIndex}`)
				end,
				DoThrow = function(slotIndex)
					print(`Throwing item from slot {slotIndex}`)
				end
			}
		}
	}

	return function()
		scope:doCleanup()
	end
end