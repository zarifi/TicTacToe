note
	description: "Summary description for {STATUS_MESSAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STATUS_MESSAGE
inherit
ANY
	redefine out end

create
	make_ok,
	make_same_name,
	make_name_start,
	make_not_turn,
	make_nosuch_player,
	make_button_taken,
	make_winner,
	make_game_not_finish,
	make_game_finish,
	make_tie

feature {NONE} -- Initialization

 	make_ok
 	do
 		err_code := err_ok
 	end

	make_same_name
	do
	err_code := err_same_name
	end

	make_name_start
	do
	err_code := err_name_start
	end

	make_not_turn
	do
	err_code := err_not_turn
	end

	make_nosuch_player
	do
	err_code := err_nosuch_player
	end

	make_button_taken
	do
		err_code := err_button_taken
	end

	make_winner
	do
	err_code := err_winner
	end

	make_game_not_finish
	do
		err_code := err_game_not_finish
	end

	make_game_finish
	do
		err_code := err_game_finish
	end

	make_tie
	do
		err_code := err_tie
	end

feature -- output

	out: STRING
	do
		Result := err_message [err_code]
	end

feature {NONE} -- Implementation

	err_code: INTEGER

	err_message: ARRAY[STRING]
	once
	create Result.make_filled ("", 1, 10)
	Result.put("ok",1)
	Result.put ("names of players must be different",2)
	Result.put("name must start with A-Z or a-z",3)
	Result.put ("not this player's turn", 4)
	Result.put ("no such player", 5)
	Result.put ("button already taken", 6)
	Result.put ("there is a winner", 7)
	Result.put ("finish this game first", 8)
	Result.put ("game is finished", 9)
	Result.put ("game ended in a tie", 10)
	end

	err_ok: INTEGER = 1
	err_same_name : INTEGER = 2
	err_name_start: INTEGER = 3
	err_not_turn: INTEGER = 4
	err_nosuch_player: INTEGER = 5
	err_button_taken: INTEGER = 6
	err_winner: INTEGER = 7
	err_game_not_finish: INTEGER = 8
	err_game_finish: INTEGER = 9
	err_tie: INTEGER = 10

	valid_message(a_message_no: INTEGER): BOOLEAN
	do
		Result := err_message.lower <= a_message_no
		and a_message_no <= err_message.upper
	ensure
		Result = (err_message.lower <= a_message_no and a_message_no <= err_message.upper)
	end

feature -- valid names
	is_valid_name(a_name:STRING): BOOLEAN
	local
		do
			Result := a_name.count >= 1
			Result := Result
			and then is_ascii_character(a_name[1])
		ensure
			Result  implies a_name.count >= 1
			Result  implies is_ascii_character(a_name[1])
		end
	is_ascii_character(c: CHARACTER): BOOLEAN
		do
			Result := (65 <= c.code and c.code <= 90)
			or (97 <= c.code and c.code <= 172)
			ensure
		Result = (65 <= c.code and c.code <= 90)
			or (97 <= c.code and c.code <= 172)
	end

end
