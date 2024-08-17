--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local Styles = require(Package.UI.Styles)
local Box = require(Package.UI.Box)
local Button = require(Package.UI.Button)

local function CloseButton(
	scope: Fusion.Scope,
	props: {
		OnClick: () -> ()
	}
): Fusion.Child
	scope = scope:innerScope {
		Box = Box,
		Button = Button
	}

	return scope:Box {
		Name = "CloseButton",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(1, -12, 0, 12),
		Size = UDim2.fromOffset(48, 48),

		[Children] = scope:Button {
			Text = "X",
			TextSize = Styles.textSize.bigger,
			Palette = Styles.colours.red,
			Size = UDim2.fromOffset(48, 48),
			OnClick = props.OnClick
		}
	}
end

return CloseButton