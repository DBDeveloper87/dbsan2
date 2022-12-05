class CreatePorfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios, id: :uuid do |t|
      t.references :channel, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
