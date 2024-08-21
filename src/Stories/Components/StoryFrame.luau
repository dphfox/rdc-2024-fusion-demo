--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Children = Fusion.Children

--- A `Frame` with more convenient properties and behaviour.
local function Box(
	scope: Fusion.Scope,
	props: {
		Parent: Instance,
		[typeof(Children)]: Fusion.Child?
	}
): Fusion.Child
	return scope:New "Frame" {
		Name = "StoryFrame",
		Parent = props.Parent,

		BackgroundColor3 = Color3.fromHex("A7B9CA"),

		Size = UDim2.fromScale(1, 1),

		[Children] = props[Children]
	}
end

return Box