class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :challenges, id: :uuid do |t|
      t.string :title
      t.datetime :start
      t.datetime :end
      t.text :description

      t.timestamps
    end
  end
end
