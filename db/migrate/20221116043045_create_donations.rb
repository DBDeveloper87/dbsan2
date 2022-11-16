class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations, id: :uuid do |t|
      t.string :program
      t.string :amount
      t.string :name
      t.string :email
      t.boolean :paid
      t.string :zip
      t.text :thank_you_note
      t.datetime :tyn_sent_at
      t.references :user, foreign_key: true, type: :uuid
      t.references :challenge_participant, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
