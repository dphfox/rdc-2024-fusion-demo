--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)

--- A series of corner rounding components that can be added to a Fusion scope.
local CornerTypes = {}

function CornerTypes.CornersMid(
	scope: Fusion.Scope
): Fusion.Child
	return scope:New "UICorner" {
		Name = "Corner Radius (Mid)",
		CornerRadius = UDim.new(0, 16)
	}
end

function CornerTypes.CornersLarge(
	scope: Fusion.Scope
): Fusion.Child
	return scope:New "UICorner" {
		Name = "Corner Radius (Large)",
		CornerRadius = UDim.new(0, 32)
	}
end

function CornerTypes.CornersFull(
	scope: Fusion.Scope
): Fusion.Child
	return scope:New "UICorner" {
		Name = "Corner Radius (Full)",
		CornerRadius = UDim.new(1, 0)
	}
end

return CornerTypes