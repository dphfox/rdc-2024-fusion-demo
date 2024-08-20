--!strict
--!nolint LocalShadow
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)
local Contextual = Fusion.Contextual

local Styles = require(Package.UI.Styles)

return {
	palette = Contextual(Styles.colours.platinum)
}