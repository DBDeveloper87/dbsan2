class CreateSynthesizeSpeechVoices < ActiveRecord::Migration[7.0]
  def change
    create_table :synthesize_speech_voices, id: :uuid do |t|
      t.references :language, null: false, foreign_key: true, type: :uuid
      t.integer :voice_type
      t.string :voice_name
      t.string :human_name
      t.integer :ssml_gender

      t.timestamps
    end
  end
end
