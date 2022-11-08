class DomainHosts
	def self.matches? request
		if Rails.env == "development"
			request.domain == "example.com"
		elsif Rails.env == "production"
			request.domain == "dbsan.org"
		end
	end
end