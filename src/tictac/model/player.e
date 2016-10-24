note
	description: "Summary description for {PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

create
	make,
	make_empty

	feature {NONE} -- Initialization
	make(a_name:STRING;a_symbol: SYMBOL)
			-- Initialization for `Current'.
		do
		name := a_name
		symbol := a_symbol
		score := 0
		winner := false
		active := false
		end

	make_empty
		do
		create name.make_empty
		create symbol.make_x
		score := 0
		winner := false
		active := false
		end

feature -- attributes

name: STRING
symbol: SYMBOL
score: INTEGER
winner: BOOLEAN
active: BOOLEAN

feature
	is_empty: BOOLEAN
	do
		Result := name.is_empty
	end

	increase_score
	do
		score := score + 1
	end

	make_active
		do
			active := true
		end
	make_false
		do
			active := false
		end

	make_winner
		do
			winner := true
		end
	revok_winner
		do
			winner := false
		end
		
end

