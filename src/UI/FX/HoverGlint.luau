--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children

local Box = require(ReplicatedStorage.UI.Components.Box)

local SPEED = 30

-- A bright gradient that animates in when hovered.
local function HoverGlint(
	scope: Fusion.Scope,
	props: {
		Decorations: Fusion.Child
	}
): Fusion.Child
	local scope = scope:innerScope {
		Box = Box
	}

	local isHovering = scope:Value(false)

	local offset = scope:Computed(function(use)
		return if use(isHovering) then Vector2.new(0, 0) else Vector2.new(0, -1)
	end)
	local transparency = scope:Computed(function(use)
		return if use(isHovering) then 0.6 else 1
	end)

	return scope:Box {
		Name = "Hover Glint",
		
		Colour = Color3.new(1, 1, 1),
		Transparency = scope:Spring(transparency, SPEED),
		ZIndex = 100,

		OnHoverStart = function()
			isHovering:set(true)
		end,
		OnHoverEnd = function()
			isHovering:set(false)
		end,

		[Children] = Fusion.Child {
			scope:New "UIGradient" {
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0),
					NumberSequenceKeypoint.new(0.4, 0),
					NumberSequenceKeypoint.new(0.6, 0.8),
					NumberSequenceKeypoint.new(1, 0.8)
				}),
				Rotation = 360 * 3 / 16,
				Offset = scope:Spring(offset, SPEED)
			},

			props.Decorations
		}
	}
end

return HoverGlint