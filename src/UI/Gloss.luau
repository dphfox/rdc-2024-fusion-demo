--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local Package = script.Parent.Parent

local Fusion = require(Package.Libraries.Fusion)

local Styles = require(Package.UI.Styles)

local function Gloss(
	scope: Fusion.Scope<typeof(Fusion)>,
	props: {
		Palette: Styles.Palette
	}
): Fusion.Child
	return scope:New "UIGradient" {
		Color = scope:Computed(function(use)
			local palette = use(props.Palette)
			return ColorSequence.new(
				ColorSequenceKeypoint.new(0, palette.fill.light),
				ColorSequenceKeypoint.new(0.4, palette.fill.mid),
				ColorSequenceKeypoint.new(0.6, palette.fill.dark),
				ColorSequenceKeypoint.new(1, palette.fill.dark)
			)
		end),
		Rotation = 90
	}
end

return Gloss