class AddChallengeToPhoto < ActiveRecord::Migration[7.0]
  def change
    add_reference :photos, :challenge, foreign_key: true, type: :uuid
    add_reference :photos, :challenge_participant, foreign_key: true, type: :uuid
    add_reference :photos, :challenge_milestone, foreign_key: true, type: :uuid
  end
end
