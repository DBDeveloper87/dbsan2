class ChannelSubdomains
	def self.matches? request
		channels = Channel.all
		subdomains = []
		channels.each do |c|
			subdomains.append(c.subdomain.slug)
		end

		if Rails.env == "development"
			request.domain == "example.com" and request.subdomain.in?(subdomains)
		end
	end
end