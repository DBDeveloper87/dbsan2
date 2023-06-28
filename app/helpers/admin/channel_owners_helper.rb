module Admin::ChannelOwnersHelper
	def user_select
		users = User.all
		user_list = []
		users.each do |u|
			user_list.append(["#{u.profile.first_name} #{u.profile.last_name} | #{u.email}", u.id])
		end
		return user_list
	end
end
