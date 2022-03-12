class CreatePolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :policies, id: :uuid do |t|
      t.string :title
      t.text :content
      t.boolean :copy_protect
      t.boolean :published
      t.datetime :published_at

      t.timestamps
    end
  end
end
