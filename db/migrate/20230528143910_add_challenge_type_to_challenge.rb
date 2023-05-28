class AddChallengeTypeToChallenge < ActiveRecord::Migration[7.0]
  def change
    add_column :challenges, :challenge_type, :integer
  end
end
