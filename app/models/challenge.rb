class Challenge < ApplicationRecord
	has_one :photo
	accepts_nested_attributes_for :photo

	has_many :challenge_participants
	has_many :users, through: :challenge_participants
	has_many :donations, through: :challenge_participants
	has_many :challenge_milestones
	has_many :frequently_asked_questions

	def faqs
		self.frequently_asked_questions
	end

	def participants
		self.challenge_participants
	end

	def milestones
		self.challenge_milestones
	end

	def total_raised
		donations = self.donations.where(paid: true)
		total = []
		donations.each do |d|
			total.append(d.amount_deci)
		end
		return total.sum
	end

	def participant_count
		self.participants.count
	end

	def total_goal
		by_milestone = []
		milestones = self.milestones.where(milestone_type: "Fundraising").all.order(goal: :asc)
		participants = self.participants
		participants.each_with_index do |p|
			p_milestones = p.milestones
			milestone_ids = []
			milestones.each do |m|
				milestone_ids.append(m.id)
			end

			p_milestone_ids = []
			if p_milestones.count == 0
				by_milestone.append(milestones.first.goal)
			else
				p_milestones.each do |m|
					p_milestone_ids.append(m.challenge_milestone_id)
				end
				if p_milestone_ids.in?(milestone_ids)
					p_milestone_ids.each do |i|
						milestone_ids.remove(i)
					end
				end
				milestones = []
				milestone_ids.each do |mi|
					milestones.append(ChallengeMilestone.find(mi))
				end
				milestones = milestones.sort_by { |k| k[:goal]}
				by_milestone.append(milestones[0].goal)
			end
		end
		return by_milestone.sum.to_f
	end

	def overall_percent
		(self.total_raised * 100 / total_goal).ceil
	end

	def top_donors
		if self.total_raised > 0
			@donations = self.donations.where(paid: true).all
			unique_emails = []
			@donations.each do |d|
				unique_emails.append(d.email)
			end
			unique_emails = unique_emails.uniq
			unique_totals = []
			unique_emails.each do |e|
				donations = @donations.where(email: e).all
				name = donations.first.name.split(" ")
				length = name.length
				name = "#{name[0]} #{name[length-1].split("")[0]}."
				total = []
				donations.each do |d|
					total.append(d.amount_deci)
				end
				total = total.sum
				unique_totals.append({
					email: e,
					name: name,
					total: total
				})
			end
			unique_totals = unique_totals.sort_by {|k| k[:total]}.reverse
			return unique_totals[0..4]
		end
	end
end
