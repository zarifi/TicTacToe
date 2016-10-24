note
	description: "Input Handler"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_INPUT_HANDLER_INTERFACE
inherit
	ETF_TYPE_CONSTRAINTS

feature {NONE}

	make_without_running(input: STRING; a_commands: ETF_ABSTRACT_UI_INTERFACE)
			-- convert an input string into array of commands
	  	do
	  		create on_error
		  	input_string := input
		  	abstract_ui  := a_commands
	  	end

	make(input: STRING; a_commands: ETF_ABSTRACT_UI_INTERFACE)
			-- convert an input string into array of commands
	  	do
	  		make_without_running(input, a_commands)
			parse_and_validate_input_string
	  	end

feature -- auxiliary queries

	etf_evt_out (evt: TUPLE[name: STRING; args: ARRAY[ETF_EVT_ARG]]): STRING
		local
			i: INTEGER
			name: STRING
			args: ARRAY[ETF_EVT_ARG]
		do
			name := evt.name
			args := evt.args
			create Result.make_empty
			Result.append (name + "(")
			from
				i := args.lower
			until
				i > args.upper
			loop
				if args[i].src_out.is_empty then
					Result.append (args[i].out)
				else
					Result.append (args[i].src_out)
				end
				if i < args.upper then
					Result.append (", ")
				end
				i := i + 1
			end
			Result.append (")")
		end

feature -- attributes

	error: BOOLEAN

	input_string: STRING -- list of commands to execute

	abstract_ui: ETF_ABSTRACT_UI_INTERFACE
		-- output generated by `parse_string'

feature -- error reporting

	on_error: ETF_EVENT [TUPLE[STRING]]

feature -- error messages

	input_cmds_syntax_err_msg : STRING =
		"Syntax Error: specification of command executions cannot be parsed"

	input_cmds_type_err_msg : STRING =
		"Type Error: specification of command executions is not type-correct"

feature -- parsing

	parse_and_validate_input_string
	  local
		trace_parser : ETF_EVT_TRACE_PARSER
		cmd : ETF_COMMAND_INTERFACE
		invalid_cmds: STRING
	  do
		create trace_parser.make (evt_param_types_list, enum_items)
		trace_parser.parse_string (input_string)

	    if trace_parser.last_error.is_empty then
	  	  invalid_cmds := find_invalid_evt_trace (
		    	trace_parser.event_trace)
		  if invalid_cmds.is_empty then
		    across trace_parser.event_trace
		    as evt
		    loop
		      cmd := evt_to_cmd (evt.item)
		      abstract_ui.put (cmd)
		    end
		  else
		    error := TRUE
		    on_error.notify (
		  	  input_cmds_type_err_msg + "%N" + invalid_cmds)
		  end
	    else
	      error := TRUE
	      on_error.notify (
		    input_cmds_syntax_err_msg + "%N" + trace_parser.last_error)
	    end
	end

	evt_to_cmd (evt : TUPLE[name: STRING; args: ARRAY[ETF_EVT_ARG]]) : ETF_COMMAND_INTERFACE
		local
			cmd_name : STRING
			args : ARRAY[ETF_EVT_ARG]
			dummy_cmd : ETF_DUMMY
		do
			cmd_name := evt.name
			args := evt.args
			create dummy_cmd.make("dummy", [], abstract_ui)

			if cmd_name ~ "new_game" then 
				 if attached {ETF_STR_ARG} args[1] as player1 and then TRUE and then attached {ETF_STR_ARG} args[2] as player2 and then TRUE then 
					 create {ETF_NEW_GAME} Result.make ("new_game", [player1.value , player2.value], abstract_ui) 
				 else 
					 Result := dummy_cmd 
				 end 

			elseif cmd_name ~ "play" then 
				 if attached {ETF_STR_ARG} args[1] as player and then TRUE and then attached {ETF_INT_ARG} args[2] as press and then 1 <= press.value and then press.value <= 9 then 
					 create {ETF_PLAY} Result.make ("play", [player.value , press.value], abstract_ui) 
				 else 
					 Result := dummy_cmd 
				 end 

			elseif cmd_name ~ "play_again" then 
				 if TRUE then 
					 create {ETF_PLAY_AGAIN} Result.make ("play_again", [], abstract_ui) 
				 else 
					 Result := dummy_cmd 
				 end 

			elseif cmd_name ~ "undo" then 
				 if TRUE then 
					 create {ETF_UNDO} Result.make ("undo", [], abstract_ui) 
				 else 
					 Result := dummy_cmd 
				 end 

			elseif cmd_name ~ "redo" then 
				 if TRUE then 
					 create {ETF_REDO} Result.make ("redo", [], abstract_ui) 
				 else 
					 Result := dummy_cmd 
				 end 
			else 
				 Result := dummy_cmd 
			end 
		end

	find_invalid_evt_trace (
		event_trace: ARRAY[TUPLE[name: STRING; args: ARRAY[ETF_EVT_ARG]]])
	: STRING
	local
		loop_counter: INTEGER
		evt: TUPLE[name: STRING; args: ARRAY[ETF_EVT_ARG]]
		cmd_name: STRING
		args: ARRAY[ETF_EVT_ARG]
		evt_out_str: STRING
	do
		create Result.make_empty
		from
			loop_counter := event_trace.lower
		until
			loop_counter > event_trace.upper
		loop
			evt := event_trace[loop_counter]
			evt_out_str := etf_evt_out (evt)

			cmd_name := evt.name
			args := evt.args

			if cmd_name ~ "new_game" then 
				if NOT( ( args.count = 2 ) AND THEN attached {ETF_STR_ARG} args[1] as player1 and then TRUE and then attached {ETF_STR_ARG} args[2] as player2 and then TRUE) then 
					if NOT Result.is_empty then
						Result.append ("%N")
					end
					Result.append (evt_out_str + " does not conform to declaration " +
							"new_game(player1: NAME = STRING ; player2: NAME = STRING)")
				end

			elseif cmd_name ~ "play" then 
				if NOT( ( args.count = 2 ) AND THEN attached {ETF_STR_ARG} args[1] as player and then TRUE and then attached {ETF_INT_ARG} args[2] as press and then 1 <= press.value and then press.value <= 9) then 
					if NOT Result.is_empty then
						Result.append ("%N")
					end
					Result.append (evt_out_str + " does not conform to declaration " +
							"play(player: NAME = STRING ; press: BUTTON = 1 .. 9)")
				end

			elseif cmd_name ~ "play_again" then 
				if FALSE then 
					if NOT Result.is_empty then
						Result.append ("%N")
					end
					Result.append (evt_out_str + " does not conform to declaration " +
							"play_again")
				end

			elseif cmd_name ~ "undo" then 
				if FALSE then 
					if NOT Result.is_empty then
						Result.append ("%N")
					end
					Result.append (evt_out_str + " does not conform to declaration " +
							"undo")
				end

			elseif cmd_name ~ "redo" then 
				if FALSE then 
					if NOT Result.is_empty then
						Result.append ("%N")
					end
					Result.append (evt_out_str + " does not conform to declaration " +
							"redo")
				end
			else
				if NOT Result.is_empty then
					Result.append ("%N")
				end
				Result.append ("Error: unknown event name " + cmd_name)
			end
			loop_counter := loop_counter + 1
		end
	end
end