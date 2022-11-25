class ParticipantMilestoneMailer < ApplicationMailer
	default from: "DBSAN Challenges <no-reply@dbsan.org>"

	def earned_milestone(milestone)
		@milestone = milestone
		@milestone_info = @milestone.challenge_milestone
		@type = @milestone_info.milestone_type
		@goal = @milestone_info.goal
		@units = @milestone_info.goal_unit

		@participant = @milestone.challenge_participant
		@challenge = @participant.challenge
		@milestones = @challenge.milestones.where(milestone_type: @type).all.order(goal: :asc)
		@milestones.each_with_index do |m, i|
			if i == 0 and m.id == @milestone_info.id
				@rank = "first"
			elsif i == 1 and m.id == @milestone_info.id
				@rank = "second"
			elsif i == 2 and m.id == @milestone_info.id
				@rank = "third"
			elsif i == 3 and m.id == @milestone_info.id
				@rank = "fourth"
			elsif i == 4 and m.id == @milestone_info.id
				@rank = "fifth"
			elsif i == 5 and m.id == @milestone_info.id
				@rank = "sixth"
			end
		end
		@rank_name = @milestone_info.name
		unless @milestone_info.photo.nil?
			@badge = @milestone_info.photo.file
		end
		@prize = @milestone_info.prize
		@email = @participant.user.email
		@name = @participant.first_name

		mail(
			to: @email, 
			bcc: "<info@dbsan.org>",
			subject: "Congrats on your new milestone!")
	end
end
