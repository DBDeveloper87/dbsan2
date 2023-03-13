class SynthesizeSpeechClip < ApplicationRecord
  belongs_to :language, optional: true
  belongs_to :cue_block
  has_one_attached :audio_file

  enum :ssml_gender, {male: 0, female: 1, neutral: 3}
end
