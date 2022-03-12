class CreateSocialNetworks < ActiveRecord::Migration[7.0]
  def change
    create_table :social_networks, id: :uuid do |t|
      t.string :name
      t.string :icon_class
      t.string :url

      t.timestamps
    end
  end
end
