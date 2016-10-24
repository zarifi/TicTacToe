note
	description: "Summary description for {TICTAC_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TICTAC_GAME

inherit

	ANY
		redefine
			out
		end

create
	make

feature {NONE}

	make
		do
			create name1.make_empty
			create name2.make_empty
			create board.make_filled("",1,9)
		end

feature --attributes

	name1: PLAYER

	name2: PLAYER

	board: ARRAY [STRING]

	empty: detachable PLAYER

feature

	initialize (player1: PLAYER; player2: PLAYER)
		do
			name1 := player1
			name2 := player2
			empty := player1

		end

	out: STRING
		local
			column: INTEGER
		do
			create Result.make_empty
			column := 1
			across
				board as button
			loop
				if column\\4 = 0 then
					--Result.append (" ")
					Result.append ("%N")
					column := 1
				end
				if button.item.is_empty then
					Result.append ("_")
				else
					Result.append (button.item.out)
				end
				column := column + 1
			end
		end

	getPlayer (a_player: STRING): PLAYER
		do

			if a_player ~ name1.name then
				Result := name1
			elseif a_player ~ name2.name then
				Result := name2

			else
				create Result.make_empty
			end

		end

	getPlayerWS (symbol: STRING): PLAYER
		do

			if symbol ~ name1.symbol.out then
				Result := name1
			elseif symbol ~ name2.symbol.out then
				Result := name2
			else
				create Result.make_empty
			end
		end

	reset_game
		do
			across
				board as button
			loop
				button.item.make_empty
			end
		--	name1.score.set_item (0)
		--	name2.score.set_item (0)
			if(name1.winner) then
				name1.make_active
				name2.make_false
			elseif(name2.winner) then
				name1.make_false
				name2.make_active
			end
			name1.revok_winner
			name2.revok_winner

		end

	is_empty: BOOLEAN

		do
			if empty = void then
			Result  := true
			else
			Result := false

			end
		end

	finished: BOOLEAN
		do

			if name1.winner or name2.winner then
				Result := true
			else
				Result := false

			end
		end
	current_player: PLAYER
		do
			if name1.active then
				Result := name1
			elseif name2.active then
				Result := name2
			else
				if name1.score > name2.score then
					Result := name1
				else
					Result := name2
				end

			end
		end
	is_valid_button(num: INTEGER): BOOLEAN
		do
			if board[num].is_empty then
				Result := true
			else
				Result := false
			end
		end
	winner_exists: BOOLEAN
		do
			if name1.winner or name2.winner then
				Result := true
			else
				Result := false

			end
		end



end

