class CreateTextTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :languages, id: :uuid do |t|
      t.string :name
      t.string :dialect
      t.string :lang_type, null: false, default: 0
      t.string :short_code
      t.string :long_code
      t.references :video

      t.timestamps
    end

    add_column :videos, :description, :text
    add_column :videos, :status, :string
    add_column :videos, :access, :integer
    add_column :videos, :visibility, :integer
    add_column :videos, :chroma_keyed, :boolean

    create_table :text_tracks, id: :uuid do |t|
      t.references :video, null: false, foreign_key: true, type: :uuid
      t.string :label
      t.references :language, null: false, foreign_key: true, type: :uuid
      t.integer :status
      t.datetime :published_at

      t.timestamps
    end
  end
end
