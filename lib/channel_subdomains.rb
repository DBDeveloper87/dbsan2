class ChannelSubdomains
	def self.matches? request
		channels = Channel.all
		subdomains = []
		domains = []
		channels.each do |c|
			subdomains.append(c.subdomain.slug)
			domains.append(c.domain_host)
		end
		domains = domains.uniq

		if Rails.env == "development"
			request.domain == "example.com" and request.subdomain.in?(subdomains)
		elsif Rails.env == "production"
			if request.domain == "dbsan.org"
				request.subdomain.in?(subdomains)
			else
				request.domain.in?(domains)
			end
		end
	end
end