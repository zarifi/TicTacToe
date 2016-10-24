note
	description: "Summary description for {SYMBOL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SYMBOL
	inherit
		ANY
		redefine
			out
		end
create
	make_x,
	make_o

feature
	make_x
	do
	create symbol.make_from_string("X")
	end

	make_o
	do
		create symbol.make_from_string("O")
	end

feature -- attribute
	symbol: STRING

feature
		out: STRING
		do
			create Result.make_from_string(symbol)
		end


end

