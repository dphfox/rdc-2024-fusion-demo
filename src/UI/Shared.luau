--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Libraries.Fusion)
local Contextual = Fusion.Contextual

local Styles = require(ReplicatedStorage.UI.Styles)

--- Variables which are shared across all UI modules.
return {
	INVENTORY_SLOTS = 16,
	
	palette = Contextual(Styles.colours.platinum)
}