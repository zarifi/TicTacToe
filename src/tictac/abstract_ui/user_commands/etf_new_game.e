note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_GAME
inherit
	ETF_NEW_GAME_INTERFACE
		redefine new_game end
create
	make
feature -- command
	new_game(player1: STRING ; player2: STRING)
		require else
			new_game_precond(player1, player2)
		local
			m: STATUS_MESSAGE
			--me: TICTAC
    	do
    		create m.make_ok
    		if player1 ~ player2 then
    			create m.make_same_name
    		--	game.set_message(m)
    			model.set_message (m)
    		elseif not m.is_valid_name (player1) or not m.is_valid_name (player2) then
    			create m.make_name_start
    			model.set_message(m)
    		else
    			model.new_game(player1,player2)
    			model.set_message(m)
    		end
			-- perform some update on the model state
		--	model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end

