--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local TextService = game:GetService("TextService")

local Package = script.Parent.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local Shared = require(Package.UI.Shared)

--- A `Frame` with more convenient properties and behaviour.
local function Box(
	scope: Fusion.Scope,
	props: {
		Name: Fusion.UsedAs<string>?,

		Position: Fusion.UsedAs<UDim2>?,
		AnchorPoint: Fusion.UsedAs<Vector2>?,
		Size: Fusion.UsedAs<UDim2>?,
		ZIndex: Fusion.UsedAs<number>?,
		LayoutOrder: Fusion.UsedAs<number>?,
		Visible: Fusion.UsedAs<boolean>?,

		Text: Fusion.UsedAs<string>,
		TextSize: Fusion.UsedAs<number>,
		Font: Fusion.UsedAs<Enum.Font>,
		TextColour: Fusion.UsedAs<Color3>?,

		OnActivated: nil | () -> (),
		OnHoverStart: nil | () -> (),
		OnHoverEnd: nil | () -> (),

		[typeof(Children)]: Fusion.Child?
	}
): Fusion.Child
	local palette = Shared.palette:now()

	local textBounds = scope:Computed(function(use)
		return TextService:GetTextSize(
			use(props.Text),
			use(props.TextSize),
			use(props.Font),
			Vector2.one * math.huge
		)
	end)

	return scope:New "TextLabel" {
		Name = props.Name or "Text",

		BackgroundTransparency = 1,
		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		Size = scope:Computed(function(use)
			local bounds = use(textBounds)
			return UDim2.fromOffset(bounds.X, bounds.Y)
		end),
		ZIndex = props.ZIndex,
		LayoutOrder = props.LayoutOrder,
		Visible = props.Visible,

		Text = props.Text,
		TextSize = props.TextSize,
		TextColor3 = props.TextColour or palette.text,
		Font = props.Font
	}
end

return Box