module Admin::BoardMembersHelper
	def position_list
		[
			["President", "President"],
			["Vice President", "Vice President"],
			["Treasurer", "Treasurer"],
			["Secretary", "Secretary"],
			["Member at Large", "Member At Large"]
		]
	end

	def pronoun_list
		[
			"He/Him/His",
			"She/Her/Hers",
			"They/Them/Their",
			"Zie/Zim/Zir",
			"Sie/Sie/Hir",
			"Ey/Em/Eir",
			"Ve/Ver/Vis",
			"Tey/Ter/Tem",
			"E/Em/Eir",
			"Prefer not to disclose"			
		]
	end
end
