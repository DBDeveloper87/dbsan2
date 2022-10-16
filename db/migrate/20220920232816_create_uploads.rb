class CreateUploads < ActiveRecord::Migration[7.0]
  def change
    create_table :uploads, id: :uuid do |t|
      t.text :file_list
      t.string :for
      t.string :for_id
      t.string :input_id

      t.timestamps
    end
  end
end
