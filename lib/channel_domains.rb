class ChannelDomains
	def self.matches? request
		channels = Channel.all
		subdomains = []
		channels.each do |c|
			subdomains.append(c.slug)
		end

		subdomains.each do |s|
			request.subdomain == s
		end
	end
end