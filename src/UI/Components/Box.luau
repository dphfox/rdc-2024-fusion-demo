--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

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

		Transparency: Fusion.UsedAs<number>?,
		Colour: Fusion.UsedAs<Color3>?,

		OnActivated: nil | () -> (),
		OnHoverStart: nil | () -> (),
		OnHoverEnd: nil | () -> (),

		[typeof(Children)]: Fusion.Child?
	}
): Fusion.Child
	return scope:New "ImageButton" {
		Name = props.Name or "Box",

		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		Size = props.Size or UDim2.fromScale(1, 1),
		ZIndex = props.ZIndex,
		LayoutOrder = props.LayoutOrder,
		Visible = props.Visible,

		BackgroundTransparency = props.Transparency or 1,
		BackgroundColor3 = props.Colour,

		[OnEvent "Activated"] = props.OnActivated,
		[OnEvent "MouseEnter"] = props.OnHoverStart,
		[OnEvent "MouseLeave"] = props.OnHoverEnd,

		[Children] = props[Children]
	}
end

return Box