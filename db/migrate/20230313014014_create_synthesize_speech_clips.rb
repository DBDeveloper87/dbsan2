class CreateSynthesizeSpeechClips < ActiveRecord::Migration[7.0]
  def change
    create_table :synthesize_speech_clips, id: :uuid do |t|
      t.references :language, foreign_key: true, type: :uuid
      t.string :language_code
      t.string :voice_name
      t.integer :ssml_gender
      t.text :encoded_text
      t.references :cue_block, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
