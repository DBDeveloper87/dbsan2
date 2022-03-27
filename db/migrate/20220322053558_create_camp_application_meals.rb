class CreateCampApplicationMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :camp_application_meals, id: :uuid do |t|
      t.references :camp_application, null: false, foreign_key: true, type: :uuid
      t.string :dietary_lifestyle
      t.text :allergens
      t.text :dietary_restrictions

      t.timestamps
    end
  end
end
