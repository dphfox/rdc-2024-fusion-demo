--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

export type Item = {
	name: string,
	description: string,
	icon: string
}

local function Item(
	x: Item
)
	return x
end

return {
	strawberry = Item {
		name = "Strawberry",
		description = "Most would argue it tastes more like a berry than a straw, but that's probably preferable.",
		icon = "rbxassetid://534533607"
	},

	pepper = Item {
		name = "Pepper",
		description = "Whether in a dish or in a spray, one thing can be said for sure about the pepper: it isn't salt.",
		icon = "rbxassetid://8981932662"
	},

	watermelon = Item {
		name = "Watermelon",
		description = "In an attempt to modernise, some Halloween parties have started to bob for watermelons instead.",
		icon = "rbxassetid://13259903532"
	},

	tomato = Item {
		name = "Tomato",
		description = "Scientists wonder: is it a fruit or a vegetable? We threw several at them until they stopped asking.",
		icon = "rbxassetid://9147788334"
	}
}