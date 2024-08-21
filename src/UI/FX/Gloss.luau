--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)

local Shared = require(ReplicatedStorage.UI.Shared)

--- A reflective gradient that adopts the current colour palette.
local function Gloss(
	scope: Fusion.Scope,
	props: {}
): Fusion.Child
	local palette = Shared.palette:now()

	return scope:New "UIGradient" {
		Name = "Gloss",
		Color = scope:Computed(function(use)
			return ColorSequence.new {
				ColorSequenceKeypoint.new(0, palette.fill.light),
				ColorSequenceKeypoint.new(0.4, palette.fill.mid),
				ColorSequenceKeypoint.new(0.6, palette.fill.dark),
				ColorSequenceKeypoint.new(1, palette.fill.dark)
			}
		end),
		Rotation = 90
	}
end

return Gloss