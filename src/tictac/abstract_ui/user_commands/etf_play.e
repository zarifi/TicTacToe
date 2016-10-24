note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY
inherit
	ETF_PLAY_INTERFACE
		redefine play end
create
	make
feature -- command
	play(player: STRING ; press: INTEGER_64)
		require else
			play_precond(player, press)
		local
			m: STATUS_MESSAGE

    	do

    		if model.game.name1.name /~ player and model.game.name2.name /~ player then
    			create m.make_nosuch_player
    			model.set_message (m)
    		elseif model.game.finished then
    			create m.make_game_finish
    			model.set_message (m)
    		elseif model.game.current_player.name /~ player then
    			create m.make_not_turn
    			model.set_message (m)
    		elseif not model.game.is_valid_button (press.as_integer_32) then
    			create m.make_button_taken
    			model.set_message (m)
    		else
    			create m.make_ok
    			model.set_message (m)
    			model.play (player, press)
    			model.hp_status
    		end


			-- perform some update on the model state
			etf_cmd_container.on_change.notify ([Current])
    	end

end

