class ChannelDomains
	def self.matches? request
		channels = Channel.all
		subdomains = []
		channels.each do |c|
			subdomains.append(c.subdomain.slug)
		end

		request.subdomain.in?(subdomains)
	end
end