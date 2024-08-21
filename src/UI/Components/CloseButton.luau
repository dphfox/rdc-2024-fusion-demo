--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children

local Styles = require(ReplicatedStorage.UI.Styles)
local Shared = require(ReplicatedStorage.UI.Shared)
local Box = require(ReplicatedStorage.UI.Components.Box)
local Button = require(ReplicatedStorage.UI.Components.Button)

--- A `Button` configured with a standard 'red X' look and feel.
local function CloseButton(
	scope: Fusion.Scope,
	props: {
		Position: Fusion.UsedAs<UDim2>?,
		AnchorPoint: Fusion.UsedAs<Vector2>?,

		OnActivated: () -> ()
	}
): Fusion.Child
	local scope = scope:innerScope {
		Box = Box,
		Button = Button
	}

	return scope:Box {
		Name = "Close Button",
		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		Size = UDim2.fromOffset(48, 48),

		[Children] = 
			Shared.palette
			:is(Styles.colours.red)
			:during(function()
				return scope:Button {
					Text = "X",
					TextSize = Styles.textSizes.bigger,
					Size = UDim2.fromScale(1, 1),
					
					OnActivated = props.OnActivated
				}
			end)
	}
end

return CloseButton