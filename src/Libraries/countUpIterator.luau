--!strict
-- Licensed under MIT from RDC 2024: Using UI Frameworks to Conquer Code Complexity

local function countUpIterator()
	local count = 0
	return function(): number
		count += 1
		return count
	end
end

return countUpIterator