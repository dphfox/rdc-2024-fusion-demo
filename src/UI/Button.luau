--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local TextService = game:GetService("TextService")

local Package = script.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local Styles = require(Package.UI.Styles)
local Box = require(Package.UI.Box)
local Stroke = require(Package.UI.Stroke)
local CornerTypes = require(Package.UI.CornerTypes)
local Gloss = require(Package.UI.Gloss)
local Text = require(Package.UI.Text)

local FONT = Enum.Font.LuckiestGuy
local PADDING_HORIZONTAL = 15
local PADDING_VERTICAL = 8

local function Button(
	scope: Fusion.Scope,
	props: {
		Name: Fusion.UsedAs<string>?,

		Text: Fusion.UsedAs<string>,
		TextSize: Fusion.UsedAs<number>?,

		Palette: Styles.Palette,

		LayoutOrder: Fusion.UsedAs<number>?,
		Size: Fusion.UsedAs<UDim2>?,

		OnActivated: nil | () -> ()
	}
): Fusion.Child
	local scope = scope:innerScope(CornerTypes, {
		Box = Box,
		Stroke = Stroke,
		Gloss = Gloss,
		Text = Text,
	})

	local realTextSize = scope:Computed(function(use)
		return use(props.TextSize) or Styles.textSizes.buttons
	end)

	local textBounds = scope:Computed(function(use)
		return TextService:GetTextSize(
			use(props.Text),
			use(realTextSize),
			FONT,
			Vector2.one * math.huge
		)
	end)

	return scope:Box {
		Name = props.Name or "Button",

		LayoutOrder = props.LayoutOrder,
		Size = props.Size or scope:Computed(function(use): UDim2
			local bounds = use(textBounds)
			return UDim2.fromOffset(
				bounds.X + PADDING_HORIZONTAL * 2,
				bounds.Y + PADDING_VERTICAL * 2
			)
		end),

		[Children] = {
			scope:Box {
				Name = "Body",
				OnActivated = props.OnActivated,

				[Children] = {
					scope:CornersMid(),

					scope:Gloss {
						Palette = props.Palette
					},

					scope:Stroke {
						Mode = Enum.ApplyStrokeMode.Border,
						Top = props.Palette.stroke.light,
						Bottom = props.Palette.stroke.mid
					},
		
					scope:Text {
						Position = UDim2.new(0.5, 0, 0.5, 4),
						AnchorPoint = Vector2.new(0.5, 0.5),
		
						Text = props.Text,
						TextSize = realTextSize,
						Font = FONT,
						Colour = props.Palette.text
					}
				}
			},

			scope:Box {
				Name = "Shadow",

				Position = UDim2.fromOffset(0, 4),
				Colour = props.Palette.stroke.dark,
				ZIndex = -1,

				[Children] = {
					scope:CornersMid(),

					scope:Stroke {
						Mode = Enum.ApplyStrokeMode.Border,
						Top = props.Palette.stroke.dark,
						Bottom = props.Palette.stroke.dark
					}
				}
			}
		}
	}
end

return Button