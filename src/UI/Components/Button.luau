--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local TextService = game:GetService("TextService")

local Package = script.Parent.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children

local Styles = require(Package.UI.Styles)
local Shared = require(Package.UI.Shared)
local Box = require(Package.UI.Components.Box)
local Text = error("TODO: implement this")--require(Package.UI.Components.Text)
local Stroke = require(Package.UI.FX.Stroke)
local CornerTypes = require(Package.UI.FX.CornerTypes)
local Gloss = require(Package.UI.FX.Gloss)

local FONT = Enum.Font.LuckiestGuy
local PADDING_HORIZONTAL = 15
local PADDING_VERTICAL = 8

--- A glossy-styled button that adopts the current colour palette.
local function Button(
	scope: Fusion.Scope,
	props: {
		Name: Fusion.UsedAs<string>?,

		Text: Fusion.UsedAs<string>,
		TextSize: Fusion.UsedAs<number>?,

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

	local palette = Shared.palette:now()

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

					scope:Gloss {},

					scope:Stroke {
						Mode = Enum.ApplyStrokeMode.Border,
						Top = palette.stroke.light,
						Bottom = palette.stroke.mid
					},
		
					scope:Text {
						Position = UDim2.new(0.5, 0, 0.5, 4),
						AnchorPoint = Vector2.new(0.5, 0.5),
		
						Text = props.Text,
						TextSize = realTextSize,
						Font = FONT
					}
				}
			},

			scope:Box {
				Name = "Shadow",

				Position = UDim2.fromOffset(0, 4),
				Colour = palette.stroke.dark,
				ZIndex = -1,

				[Children] = {
					scope:CornersMid(),

					scope:Stroke {
						Mode = Enum.ApplyStrokeMode.Border,
						Top = palette.stroke.dark,
						Bottom = palette.stroke.dark
					}
				}
			}
		}
	}
end

return Button