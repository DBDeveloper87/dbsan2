module CampApplicationMealsHelper
	def dietary_lifestyle
		[
			["omnivore", "Omnivore (Can eat anything)"],
			["vegetarian", "Vegetarian (No meat)"],
			["vegan", "Vegan (No eggs, dairy, or any product derived from an animal)"],
			["paleo", "Paleo (a diet similar to 10,000 years ago)"],
			["keto", "Keto (low carb)"]
		]
	end

		def allergen_sensitive
			[
				["lactose", "Lactose intolerant"],
				["gluten", "Gluten"],
				["tree_nuts", "Tree nuts"],
				["peanuts", "Peanuts"]
			]
		end
end
