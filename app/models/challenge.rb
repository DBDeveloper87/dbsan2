class Challenge < ApplicationRecord
	enum status: {draft: 0,
					published: 1,
					completed: 3
	}

	has_one :photo
	accepts_nested_attributes_for :photo

	has_many :challenge_participants
	has_many :users, through: :challenge_participants
	has_many :donations, through: :challenge_participants
	has_many :challenge_milestones
	has_many :frequently_asked_questions
	has_many :exercise_trackers, through: :challenge_participants
	
	def duplicate_challenge
		new_challenge = self.dup
		new_challenge.title = self.title + "Copy"
		new_challenge.status = "draft"
		new_challenge.save

		self.faqs.each do |f|
			new_faq = f.dup
			new_faq.challenge_id = new_challenge.id
			new_faq.save
		end
	end

	def faqs
		self.frequently_asked_questions
	end

	def activities
		self.exercise_trackers
	end

	def exercise_activity_options
		[
			"Cycling (indoors)", 
			"Cycling (outdoors)", 
			"Dancing", 
			"Elliptical", 
			"Hiking", 
			"Martial arts", 
			"Rowing", 
			"Running (indoors)", 
			"Running (outdoors)", 
			"Skiing", 
			"Swimming", 
			"Walking (indoors)", 
			"Walking (outdoors)", 
			"Weight lifting", 
			"Yoga", 
			"Other"
		]
	end

	def activity_values
		values = []
		self.exercise_activity_options.each do |ea|
			total = []
			activities = self.activities.where(activity: ea).all
			activities.each do |a|
				time = a.time
				hour = time.hour
				minute = time.min
				second = time.sec
				if second > 0
					minute = minute + 1
				end
				if hour > 0
					minutes = minute + (60 * hour)
				else
					minutes = minute
				end
				total.append(minutes)
			end
			values.append(total.sum)
		end
		return values
	end

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
		if total.empty?
			return 0
		else
			return total.sum
		end
	end

	def total_time
		total = []
		self.participants.each do |p|
			total.append(p.total_time)
		end
		return total.sum
	end

	def total_time_in_words
		total_time = self.total_time
		hours = total_time / 60
		minutes = total_time % 60
		if hours > 0 and minutes == 0
			return "#{hours} Hours"
		elsif hours > 0 and minutes > 0
			return "#{hours} Hours and #{minutes} Minutes"
		elsif hours == 0 and minutes > 0
			return "#{minutes} Minutes"
		else
			return "No Activity Logged Yet"
		end
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
		if total_goal == 0
			return 0
		else
			(self.total_raised * 100 / total_goal).ceil
		end
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
