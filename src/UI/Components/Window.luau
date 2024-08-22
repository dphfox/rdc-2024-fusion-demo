--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children

local Shared = require(ReplicatedStorage.UI.Shared)
local Box = require(ReplicatedStorage.UI.Components.Box)
local Gradient = require(ReplicatedStorage.UI.FX.Gradient)
local CornerTypes = require(ReplicatedStorage.UI.FX.CornerTypes)
local Stroke = require(ReplicatedStorage.UI.FX.Stroke)
local Wobbler = require(ReplicatedStorage.UI.FX.Wobbler)

--- A large, centred rectangular box that adopts the current colour palette.
local function Window(
	scope: Fusion.Scope,
	props: {
		Name: Fusion.UsedAs<string>?,
		Visible: Fusion.UsedAs<boolean>?,
		[typeof(Children)]: Fusion.Child
	}
): Fusion.Child
	local scope = scope:innerScope(CornerTypes, {
		Box = Box,
		Gradient = Gradient,
		Stroke = Stroke,
		Wobbler = Wobbler
	})

	local palette = Shared.palette:now()

	return scope:Box {
		Name = props.Name or "Window",

		Position = scope:Wobbler {
			RestAt = UDim2.fromScale(0.5, 0.5),
			WobbleVelocity = UDim2.fromOffset(0, -1000),
			SpringSpeed = 25,
			SpringDamping = 1,
			RespondTo = props.Visible,
			ResponseType = "whenTruthy"
		},
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(600, 370),

		

		Visible = props.Visible,

		[Children] = {
			scope:Box {
				Name = "Body",

				Colour = Color3.new(1, 1, 1),

				[Children] = {
					scope:CornersLarge(),

					scope:Gradient {
						Top = palette.fill.mid,
						Bottom = palette.fill.dark
					},

					scope:Stroke {
						Mode = Enum.ApplyStrokeMode.Border,
						Top = palette.stroke.light,
						Bottom = palette.stroke.mid
					},

					props[Children]
				}
			},

			scope:Box {
				Name = "Shadow",

				Position = UDim2.fromOffset(0, 4),
				Colour = palette.stroke.dark,
				ZIndex = -1,

				[Children] = {
					scope:CornersLarge(),

					scope:Stroke {
						Mode = Enum.ApplyStrokeMode.Border,
						Top = palette.stroke.dark,
						Bottom = palette.stroke.dark
					}
				}
			},
		}
	}
end

return Window