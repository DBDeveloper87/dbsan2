class CreateBoardMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :board_members, id: :uuid do |t|
      t.string :name
      t.string :position
      t.text :bio
      t.string :pronouns

      t.timestamps
    end
  end
end
