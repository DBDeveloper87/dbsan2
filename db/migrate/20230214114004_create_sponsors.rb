class CreateSponsors < ActiveRecord::Migration[7.0]
  def change
    create_table :sponsors, id: :uuid do |t|
      t.string :name
      t.string :website

      t.timestamps
    end
  end
end
