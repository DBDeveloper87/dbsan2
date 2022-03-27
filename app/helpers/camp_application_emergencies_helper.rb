module CampApplicationEmergenciesHelper
	def relationships
		[
			["parent", "Parent"],
			["sibling", "Sibling / Brother / Sister"],
			["spouse", "Spouse / Husband / Wife / Partner"],
			["friend", "Friend"]
		]
	end
end
