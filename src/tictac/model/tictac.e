note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	TICTAC

inherit

	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
				--create s.make_empty
			i := 0
			create s.make_empty
			create status_message.make_ok
		end

feature -- model attributes

	s: STRING

	i: INTEGER

	status_message: STATUS_MESSAGE

	game: TICTAC_GAME

		once
			create Result.make
		end

feature --model operations

	new_game (a_player1: STRING; a_player2: STRING)
		require
			a_player1 /= a_player2
		local
			player1: PLAYER
			player2: PLAYER
		do
			create player1.make (a_player1, create {SYMBOL}.make_x)
			create player2.make (a_player2, create {SYMBOL}.make_o)
			game.initialize (player1, player2)
			player1.make_active
		end

	play (player: STRING; press: INTEGER_64)
		local
			symbol: STRING
		do


						if(not game.name1.active and not game.name2.active) then
		    				game.getplayer (player).make_active

		    			elseif(game.getplayer (player).active  and game.name1.name ~ player) then
		    				game.name1.make_false
		    				game.name2.make_active
		    			elseif(game.getplayer (player).active and game.name2.name ~ player) then
		    				game.name2.make_false
		    				game.name1.make_active
		    			end

				symbol := game.getplayer(player).symbol.out
    			game.board[press.as_integer_32] := symbol



     if(
     (game.board[1] ~ "X" and game.board[2] ~ "X" and game.board[3] ~ "X")or
     (game.board[4] ~ "X" and game.board[5] ~ "X" and game.board[6] ~ "X")or
     (game.board[7] ~ "X" and game.board[8] ~ "X" and game.board[9] ~ "X")or
     (game.board[1] ~ "X" and game.board[4] ~ "X" and game.board[7] ~ "X")or
     (game.board[2] ~ "X" and game.board[5] ~ "X" and game.board[8] ~ "X")or
     (game.board[1] ~ "X" and game.board[5] ~ "X" and game.board[9] ~ "X")or -- for accross
     (game.board[3] ~ "X" and game.board[5] ~ "X" and game.board[7] ~ "X")or -- for accross
     (game.board[3] ~ "X" and game.board[6] ~ "X" and game.board[9] ~ "X")) then
     game.getplayerWS ("X").increase_score
     game.getplayerWS("X").make_winner


     elseif(
     (game.board[1] ~ "O" and game.board[2] ~ "O" and game.board[3] ~ "O")or
     (game.board[4] ~ "O" and game.board[5] ~ "O" and game.board[6] ~ "O")or
     (game.board[7] ~ "O" and game.board[8] ~ "O" and game.board[9] ~ "O")or
     (game.board[1] ~ "O" and game.board[4] ~ "O" and game.board[7] ~ "O")or
     (game.board[2] ~ "O" and game.board[5] ~ "O" and game.board[8] ~ "O")or
     (game.board[1] ~ "O" and game.board[5] ~ "O" and game.board[9] ~ "O")or -- for accross
     (game.board[3] ~ "O" and game.board[5] ~ "O" and game.board[7] ~ "O")or -- for accross
     (game.board[3] ~ "O" and game.board[6] ~ "O" and game.board[9] ~ "O")) then
      game.getplayerWS ("O").increase_score
      game.getplayerWS ("O").make_winner
    end
end

		playe_again
		do
			game.reset_game
		end

feature -- model operations

	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	reset
			-- Reset model state.
		do
			make
		end

	set_message (message: STATUS_MESSAGE)
		do
			status_message := message
		end

	message_ok: STRING
	attribute Result := "play next" end

	message_finished: STRING
	attribute Result := "play again or start new game" end

	message_new: STRING
	attribute Result := "start new game" end

	hp_status
	do
		if game.finished then
			if game.winner_exists then
				set_message(create {STATUS_MESSAGE}.make_winner)
			else
				set_message(create {STATUS_MESSAGE}.make_tie)

			end

		end

	end

feature -- queries

	out: STRING
		do
			create Result.make_from_string ("  ")
				--	Result.append ("System State: default model state ")
				--
				--			Result.append ("(")
				--			Result.append (i.out)
				--			Result.append (")")
				--	       Result.append (game.out)
				--		Result.append ("testing")

				--	Result.append ("%N")
		--	Result.append("current playere test: "+game.current_player.name+" name1: "+game.name1.active.out+" name2: "+game.name2.active.out)
			Result.append(status_message.out)
			Result.append(": => ")
			if game.is_empty then
				Result.append (message_new)
			elseif game.finished then
				Result.append(message_finished)
			else
				Result.append(game.current_player.name+" "+ message_ok)
			end

			Result.append(game.out)
			Result.append("%N")
			Result.append (" "+game.name1.score.out+": score for %""+game.name1.name+"%"(as X)")
			Result.append("%N")
			Result.append (" "+game.name2.score.out+": score for %""+game.name2.name+"%"(as O)")

		end

end

