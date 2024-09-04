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
	magnet = Item {
		name = "Magnet",
		description = "If you're not a fan of magnets, I'd consider us polar opposites.",
		icon = "rbxassetid://110654543696490"
	},

	book = Item {
		name = "Book",
		description = "The cover makes it hard to know if you're reading it upside down or not, but nobody else will know either.",
		icon = "rbxassetid://96927562699084"
	},

	board = Item {
		name = "Board",
		description = "A crucial part of building any home. Not this one though, you found it on the curb.",
		icon = "rbxassetid://84223045075987"
	}
}