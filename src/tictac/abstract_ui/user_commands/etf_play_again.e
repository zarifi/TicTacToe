note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY_AGAIN
inherit
	ETF_PLAY_AGAIN_INTERFACE
		redefine play_again end
create
	make
feature -- command
	play_again
		local
			m: STATUS_MESSAGE
    	do

    		if not model.game.finished then
    			create m.make_game_not_finish
    			model.set_message (m)
    		else
    			create m.make_ok
    			model.set_message (m)
    			model.playe_again
    	 end
			-- perform some update on the model state
			--model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end

