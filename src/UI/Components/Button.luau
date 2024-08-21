--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local TextService = game:GetService("TextService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children

local Styles = require(ReplicatedStorage.UI.Styles)
local Shared = require(ReplicatedStorage.UI.Shared)
local Box = require(ReplicatedStorage.UI.Components.Box)
local Text = require(ReplicatedStorage.UI.Components.Text)
local Stroke = require(ReplicatedStorage.UI.FX.Stroke)
local CornerTypes = require(ReplicatedStorage.UI.FX.CornerTypes)
local Gloss = require(ReplicatedStorage.UI.FX.Gloss)
local HoverGlint = require(ReplicatedStorage.UI.FX.HoverGlint)

local PADDING_HORIZONTAL = 16
local PADDING_VERTICAL = 12

--- A glossy-styled button that adopts the current colour palette.
local function Button(
	scope: Fusion.Scope,
	props: {
		Name: Fusion.UsedAs<string>?,

		Text: Fusion.UsedAs<string>,
		TextSize: Fusion.UsedAs<number>?,

		Position: Fusion.UsedAs<UDim2>?,
		AnchorPoint: Fusion.UsedAs<Vector2>?,
		Size: Fusion.UsedAs<UDim2>?,
		LayoutOrder: Fusion.UsedAs<number>?,

		OnActivated: nil | () -> ()
	}
): Fusion.Child
	local scope = scope:innerScope(CornerTypes, {
		Box = Box,
		Stroke = Stroke,
		Gloss = Gloss,
		Text = Text,
		HoverGlint = HoverGlint
	})

	local palette = Shared.palette:now()

	local realTextSize = scope:Computed(function(use)
		return use(props.TextSize) or Styles.textSizes.buttons
	end)

	local textBounds = scope:Computed(function(use)
		return TextService:GetTextSize(
			use(props.Text),
			use(realTextSize),
			Styles.fonts.title,
			Vector2.one * math.huge
		)
	end)

	local isPressing = scope:Value(false)

	return scope:Box {
		Name = props.Name or "Button",

		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		Size = props.Size or scope:Computed(function(use): UDim2
			local bounds = use(textBounds)
			return UDim2.fromOffset(
				bounds.X + PADDING_HORIZONTAL * 2,
				bounds.Y + PADDING_VERTICAL * 2
			)
		end),
		LayoutOrder = props.LayoutOrder,
		OnActivated = props.OnActivated,

		OnPressStart = function()
			isPressing:set(true)
		end,
		OnPressEnd = function()
			isPressing:set(false)
		end,

		[Children] = {
			scope:Box {
				Name = "Body",

				Position = scope:Spring(scope:Computed(function(use)
					return UDim2.fromOffset(
						0,
						if use(isPressing) then 4 else 0
					)
				end), 40),

				Colour = Color3.new(1, 1, 1),

				[Children] = {
					scope:CornersMid(),

					scope:Gloss {},
					scope:HoverGlint {
						Decorations = scope:CornersMid()
					},

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
						Font = Styles.fonts.title
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