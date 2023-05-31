class AddReferenceToChallengeParticipant < ActiveRecord::Migration[7.0]
  def change
    add_reference :challenge_participants, :price, foreign_key: true, type: :uuid
    add_column :challenge_participants, :paid, :boolean
  end
end
