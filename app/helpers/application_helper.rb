module ApplicationHelper
	def agree_or_decline
		[
			["true", "Agree"],
			["false", "Disagree"]
		]
	end

	def mobility_aids
		[
			["none", "None"],
			["walker", "Walker"],
			["Wheelchair", "Wheelchair"],
			["both", "Both Wheelchair and Walker"]
		]
	end

	def yes_no
		[
			["true", "Yes"],
			["false", "No"]
		]
	end

	def identify_as
		[
			"DeafBlind",
			"Deaf",
			"Hard of Hearing and can understand speech",
			"Hard of Hearing and cannot understand speech",
			"Hearing",
			"Blind",
			"Low Vision / Close Vision",
			"Night Blindness",
			"Tunnel Vision",
			"Sighted"
		]
	end

	def comm_prefs
		[
			["protactile_pt", "ProTactile (PT)"],
			["tactile_asl", "Tactile ASL (TASL)"],
			["visual_asl", "Visual ASL (VASL)"],
			["limited_range", "Limited Field of View ASL"],
			["close_visual", "Close Visual ASL (CV)"],
			["tactile_fingerspelling", "Tactile Fingerspelling"],
			["print_on_palm", "Print on Palm"],
			["haptics", "Haptics / Touch Signals"],
			["spoken_english", "Spoken English"],
			["spoken_spanish", "Spoken Spanish"],
			['typed_language', "Typed Language"],
			["refreshable_braille", "Refreshable Braille"]
		]
	end

	def tactile_receptive_hand
		[
			"Left",
			"Right",
			"Both"
		]
	end

	def hands
		[ 
			"Left",
			"Right"
		]
	end

	def matchup_types
		[
			"Younger",
			"Older",
			"Men",
			"Women",
			"Non-binary",
			"Gender-neutral",
			"Gender-fluid",
			"Deaf",
			"Hard of Hearing",
			"Hearing",
			"Doesn't matter"
		]
	end

	def self_height
		[
			["5_4_or_shorter", "5\' 4\" or shorter"],
			["5_5_to_5_10", "5\' 5\" to 5\' 10\""],
			["5_10_to_6_2", "5\' 10\" to 6\' 2\""],
			["6_3_or_taller", "6\' 3\" or taller"]
		]
	end

	def self_described
		[
			["laid_back", "Laid-back"],
			["high_energy", "High energy"],
			["can_be_both", "Can be both"],
			["can_be_either", "Can be either"]
		]
	end

	def activities
		[
			"Physical activities (biking, hiking, or swimming, etc.)",
			"Calm activities (crafts, workshops, board games, etc.)",
			"Tours out of camp (Town, mall, state park, etc)"
		]
	end
end
