--!strict
--!nolint LocalShadow
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
		Position: Fusion.UsedAs<UDim2>?,
		AnchorPoint: Fusion.UsedAs<Vector2>?,
		Size: Fusion.UsedAs<UDim2>?,

		OnActivated: () -> ()
	}
): Fusion.Child
	local scope = scope:innerScope {
		Box = Box,
		Button = Button
	}

	return scope:Box {
		Name = "CloseButton",
		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		Size = props.Size,

		[Children] = scope:Button {
			Text = "X",
			TextSize = Styles.textSizes.bigger,
			Palette = Styles.colours.red,
			Size = UDim2.fromOffset(48, 48),
			
			OnActivated = props.OnActivated
		}
	}
end

return CloseButton