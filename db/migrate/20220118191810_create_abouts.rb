class CreateAbouts < ActiveRecord::Migration[7.0]
  def change
    create_table :abouts, id: :uuid do |t|
      t.string :title, null: false
      t.string :heading_level, null: false
      t.text :content, null: false
      t.boolean :published, default: false, null: false

      t.timestamps
    end
  end
end
