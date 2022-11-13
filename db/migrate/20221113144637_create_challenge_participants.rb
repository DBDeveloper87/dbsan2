class CreateChallengeParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :challenge_participants, id: :uuid do |t|
      t.references :challenge, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :first_name
      t.string :last_name
      t.string :shirt_size
      t.text :address

      t.timestamps
    end
  end
end
