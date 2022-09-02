class StoreDomain
	def self.matches? request
		request.subdomain == "store"
	end
end