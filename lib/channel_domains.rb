class ChannelDomains
	channels = Channel.all
	subdomains = []
	channels.each do |c|
		subdomains.append(c.subdomain.slug)
	end

	subdomains.each do |s|
		if self.request.subdomain == s
			return s
		end
	end
end