module CampApplicationMealsHelper
	def dietary_lifestyle
		[
			["omnivore", "Omnivore (Can eat anything)"],
			["vegetarian", "Vegetarian (No meat)"],
			["vegan", "Vegan (No eggs, dairy, or any product derived from an animal)"],
			["paleo", "Paleo"],
			["keto", "Keto"]
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
