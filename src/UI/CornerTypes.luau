--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)

local CornerTypes = {}

function CornerTypes.CornersMid(
	scope: Fusion.Scope
): Fusion.Child
	return scope:New "UICorner" {
		CornerRadius = UDim.new(0, 16)
	}
end

function CornerTypes.CornersLarge(
	scope: Fusion.Scope
): Fusion.Child
	return scope:New "UICorner" {
		CornerRadius = UDim.new(0, 32)
	}
end

function CornerTypes.CornersFull(
	scope: Fusion.Scope
): Fusion.Child
	return scope:New "UICorner" {
		CornerRadius = UDim.new(1, 0)
	}
end

return CornerTypes