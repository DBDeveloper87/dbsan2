class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :subdomains, id: :uuid do |t|
      t.string :slug, unique: true

      t.timestamps
    end
    
    create_table :channels, id: :uuid do |t|
      t.string :name
      t.references :subdomain, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
