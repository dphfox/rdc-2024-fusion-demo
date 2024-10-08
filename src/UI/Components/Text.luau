--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local TextService = game:GetService("TextService")

local Package = script.Parent.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local Shared = require(Package.UI.Shared)

local FONT_SCALES = {
	[Enum.Font.Cartoon] = 1.209,
	[Enum.Font.LuckiestGuy] = 1.000
}

--- An auto-sized text label that automatically adopts the current palette.
local function Text(
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
		WrapBounds: Fusion.UsedAs<Vector2?>,
		AlignX: Enum.TextXAlignment?,
		AlignY: Enum.TextYAlignment?,

		OnActivated: nil | () -> (),
		OnHoverStart: nil | () -> (),
		OnHoverEnd: nil | () -> (),

		[typeof(Children)]: Fusion.Child?
	}
): Fusion.Child
	local palette = Shared.palette:now()

	local realTextSize = scope:Computed(function(use)
		return FONT_SCALES[use(props.Font)] * use(props.TextSize)
	end)

	local textBounds = scope:Computed(function(use)
		return TextService:GetTextSize(
			use(props.Text),
			use(realTextSize),
			use(props.Font),
			(use(props.WrapBounds) or Vector2.one * math.huge):Floor()
		)
	end)

	return scope:New "TextLabel" {
		Name = props.Name or props.Text,

		BackgroundTransparency = 1,
		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		Size = scope:Computed(function(use)
			local bounds = use(textBounds)
			return UDim2.fromOffset(bounds.X, bounds.Y + 1)
		end),
		ZIndex = props.ZIndex,
		LayoutOrder = props.LayoutOrder,
		Visible = props.Visible,

		Text = props.Text,
		TextSize = realTextSize,
		TextColor3 = props.TextColour or palette.text,
		TextWrapped = scope:Computed(function(use)
			return use(props.WrapBounds) ~= nil
		end),
		TextXAlignment = props.AlignX,
		TextYAlignment = props.AlignY,
		Font = props.Font
	}
end

return Text