class AddFieldsToChallengeMilestone < ActiveRecord::Migration[7.0]
  def change
    add_column :challenge_milestones, :hidden, :boolean
    add_column :challenge_milestones, :description, :text
  end
end
