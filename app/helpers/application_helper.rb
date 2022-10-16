module ApplicationHelper
	def humanize_bytes(value)
		case 
		when value >= 1099511627776
			"#{number_with_precision((value / 1099511627776.00).round(2), precision: 2, delimiter: ",")} TB"
		when value.between?(1073741824, 1099511627775)
			"#{number_with_precision((value / 1073741824.00).round(2), precision: 2, delimiter: ",")} GB"
		when value.between?(1048576, 1073741823)
			"#{number_with_precision((value / 1048576.00).round(2), precision: 2, delimiter: ",")} MB"
		when value.between?(1024, 1048575)
			"#{number_with_precision((value / 1024.00).round(2), precision: 2, delimiter: ",")} KB"
		else
			"#{number_with_delimiter(value, delimiter: ",")} Bytes"
		end
	end

	def tent_or_cabin
		[
			"Tent",
			"Cabin"
		]
	end

	def bring_tent
		[
			["true", "I will bring my own tent"],
			["false", "I wish DBRIB to provide my tent"]
		]
	end

	def camp_shifts
		[
			"1st shift - 8 am to 12:30 pm",
			"2nd shift - 12:30 pm to 5 pm",
			"3rd shift - 6 pm to 10 pm",
			"Flexible (can work any shift, the scheduling team will determine which 2 shifts to work)"
		]
	end

	def training_history
		[
			"Support Service Provider training",
			"CoNavigator training",
			"Communication Facilitator training",
			"Haptics",
			"ProTactile (basics)",
			"ProTactile (advanced)",
			"Tactile ASL  (TASL)",
			"DeafBlind Workshops",
		]
	end

	def vaccination_types
		[
			"One shot of Johnson & Johnson",
			"One shot of Pfizer or Moderna",
			"Two shots of Pfizer or Moderna",
			"Booster shot"
		]
	end

	def agree_or_decline
		[
			["true", "Agree"],
			["false", "Disagree"]
		]
	end

	def gender_identities
		[
			"Male",
			"Female",
			"Non-binary",
			"Gender-fluid",
			"Gender-neutral",
			"Prefer not to disclose"
		]
	end

	def basic_pronoun_list
		[
			"He / Him / His",
			"She / Her / Hers",
			"They / Them / Their",
			"Prefer not to disclose"			
		]
	end

	def mobility_aids
		[
			["none", "None"],
			["walker", "Walker"],
			["wheelchair", "Wheelchair"],
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
			["5_11_to_6_2", "5\' 11\" to 6\' 2\""],
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
