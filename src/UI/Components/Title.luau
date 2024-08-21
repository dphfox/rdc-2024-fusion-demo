--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children

local Styles = require(ReplicatedStorage.UI.Styles)
local Shared = require(ReplicatedStorage.UI.Shared)
local Box = require(ReplicatedStorage.UI.Components.Box)
local Gloss = require(ReplicatedStorage.UI.FX.Gloss)
local Stroke = require(ReplicatedStorage.UI.FX.Stroke)

local SHADOW_DEPTHS = {0, 1, 2}

--- Large glossy inverted text with a deep drop shadow.
local function Title(
	scope: Fusion.Scope,
	props: {
		Name: Fusion.UsedAs<string>?,

		Position: Fusion.UsedAs<UDim2>?,
		AnchorPoint: Fusion.UsedAs<Vector2>?,
		ZIndex: Fusion.UsedAs<number>?,
		LayoutOrder: Fusion.UsedAs<number>?,
		Visible: Fusion.UsedAs<boolean>?,

		Text: Fusion.UsedAs<string>
	}
): Fusion.Child
	local scope = scope:innerScope {
		Box = Box,
		Gloss = Gloss,
		Stroke = Stroke
	}

	local textBounds = scope:Computed(function(use)
		return TextService:GetTextSize(
			use(props.Text),
			Styles.textSizes.title,
			Styles.fonts.title,
			Vector2.one * math.huge
		)
	end)

	return
		Shared.palette
		:is(Styles.colours.platinum)
		:during(function()
			local palette = Shared.palette:now()

			return scope:Box {
				Name = props.Name or "Title",

				Position = props.Position,
				AnchorPoint = props.AnchorPoint,
				Size = scope:Computed(function(use)
					local bounds = use(textBounds)
					return UDim2.fromOffset(bounds.X, bounds.Y)
				end),
				ZIndex = props.ZIndex,
				LayoutOrder = props.LayoutOrder,
				Visible = props.Visible,

				[Children] = scope:ForValues(
					SHADOW_DEPTHS,
					function(_, scope: typeof(scope), shadowDepth: number): Fusion.Child
						local isShadow = shadowDepth > 0

						return scope:New "TextLabel" {
							Name = `Depth {shadowDepth}`,
					
							BackgroundTransparency = 1,
							Position = UDim2.fromOffset(0, shadowDepth * 4),
							Size = UDim2.fromScale(1, 1),
							ZIndex = -shadowDepth,
					
							Text = props.Text,
							TextSize = Styles.textSizes.title,
							TextColor3 = 
								if isShadow then palette.text else Color3.new(1, 1, 1),
							Font = Styles.fonts.title,
					
							[Children] = {
								if isShadow then {} else scope:Gloss {},
								
								scope:Stroke {
									Mode = Enum.ApplyStrokeMode.Contextual,
									Top = palette.text,
									Bottom = palette.text
								}
							}
						}
					end
				)
			}
		end)
end

return Title