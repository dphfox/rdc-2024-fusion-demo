--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out

--- A `Frame` with more convenient properties and behaviour.
local function Box(
	scope: Fusion.Scope,
	props: {
		Name: Fusion.UsedAs<string>?,

		Position: Fusion.UsedAs<UDim2>?,
		AnchorPoint: Fusion.UsedAs<Vector2>?,
		Size: Fusion.UsedAs<UDim2>?,
		Rotation: Fusion.UsedAs<number>?,
		ZIndex: Fusion.UsedAs<number>?,
		LayoutOrder: Fusion.UsedAs<number>?,
		Visible: Fusion.UsedAs<boolean>?,

		Transparency: Fusion.UsedAs<number>?,
		Colour: Fusion.UsedAs<Color3>?,

		OutSize: Fusion.Value<Vector2?>?,

		OnActivated: nil | () -> (),
		OnHoverStart: nil | () -> (),
		OnHoverEnd: nil | () -> (),
		OnPressStart: nil | () -> (),
		OnPressEnd: nil | () -> (),

		[typeof(Children)]: Fusion.Child?
	}
): Fusion.Child
	local passthroughInputs = (props.OnActivated or props.OnPressStart or props.OnPressEnd) == nil
	if passthroughInputs  then
		return scope:New "Frame" {
			Name = props.Name or "Box (passthrough inputs)",
	
			Position = props.Position,
			AnchorPoint = props.AnchorPoint,
			Size = props.Size or UDim2.fromScale(1, 1),
			Rotation = props.Rotation,
			ZIndex = props.ZIndex,
			LayoutOrder = props.LayoutOrder,
			Visible = props.Visible,
	
			BackgroundTransparency = props.Transparency or if props.Colour ~= nil then 0 else 1,
			BackgroundColor3 = props.Colour,

			[Out "AbsoluteSize"] = props.OutSize,
	
			[OnEvent "MouseEnter"] = props.OnHoverStart,
			[OnEvent "MouseLeave"] = props.OnHoverEnd,
	
			[Children] = props[Children]
		}
	else
		return scope:New "ImageButton" {
			Name = props.Name or "Box",
	
			Position = props.Position,
			AnchorPoint = props.AnchorPoint,
			Size = props.Size or UDim2.fromScale(1, 1),
			Rotation = props.Rotation,
			ZIndex = props.ZIndex,
			LayoutOrder = props.LayoutOrder,
			Visible = props.Visible,
	
			BackgroundTransparency = props.Transparency or if props.Colour ~= nil then 0 else 1,
			BackgroundColor3 = props.Colour,

			[Out "AbsoluteSize"] = props.OutSize,
	
			[OnEvent "Activated"] = props.OnActivated,
			[OnEvent "MouseEnter"] = props.OnHoverStart,
			[OnEvent "MouseLeave"] = function()
				if props.OnHoverEnd ~= nil then
					props.OnHoverEnd()
				end
				if props.OnPressEnd ~= nil then
					props.OnPressEnd()
				end
			end,
			[OnEvent "MouseButton1Down"] = props.OnPressStart,
			[OnEvent "MouseButton1Up"] = props.OnPressEnd,
	
			[Children] = props[Children]
		}
	end
	
end

return Box