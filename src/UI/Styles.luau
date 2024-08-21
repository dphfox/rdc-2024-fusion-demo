--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

--- A set of colours that can be used to theme UI components.
export type Palette = {
	fill: {
		light: Color3,
		mid: Color3,
		dark: Color3
	},
	stroke: {
		light: Color3,
		mid: Color3,
		dark: Color3
	},
	text: Color3
}

local function Palette(x: Palette)
	return x
end

--- Predefined colours and metrics for use throughout UI modules.
return {
	fonts = {
		title = Enum.Font.LuckiestGuy
	},

	textSizes = {
		title = 48,
		bigger = 36,
		header = 24,
		buttons = 24,
		tooltip = 18,
		body = 16
	},

	colours = {
		platinum = Palette {
			fill = {
				light = Color3.fromHex("#FFFFFF"),
				mid = Color3.fromHex("#CCDDEE"),
				dark = Color3.fromHex("#AFC7DE")
			},
			stroke = {
				light = Color3.fromHex("#A7B9CA"),
				mid = Color3.fromHex("#8899AA"),
				dark = Color3.fromHex("#798795")
			},
			text = Color3.fromHex("#112233")
		},

		red = Palette {
			fill = {
				light = Color3.fromHex("#FF5C00"),
				mid = Color3.fromHex("#E70101"),
				dark = Color3.fromHex("#C51A24")
			},
			stroke = {
				light = Color3.fromHex("#BB0000"),
				mid = Color3.fromHex("#A20000"),
				dark = Color3.fromHex("#890000")
			},
			text = Color3.fromHex("#FFF7F3")
		},

		yellow = Palette {
			fill = {
				light = Color3.fromHex("#FFF8E0"),
				mid = Color3.fromHex("#F4CE4A"),
				dark = Color3.fromHex("#EBC12C")
			},
			stroke = {
				light = Color3.fromHex("#D5AA13"),
				mid = Color3.fromHex("#B99E0C"),
				dark = Color3.fromHex("#A58308")
			},
			text = Color3.fromHex("#362A00")
		},

		green = Palette {
			fill = {
				light = Color3.fromHex("#9EFF23"),
				mid = Color3.fromHex("#26EE46"),
				dark = Color3.fromHex("#00CE46")
			},
			stroke = {
				light = Color3.fromHex("#52BB00"),
				mid = Color3.fromHex("#069941"),
				dark = Color3.fromHex("#078338")
			},
			text = Color3.fromHex("#004019")
		}
	}
}

