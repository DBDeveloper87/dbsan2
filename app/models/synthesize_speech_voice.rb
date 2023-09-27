class SynthesizeSpeechVoice < ApplicationRecord
  belongs_to :language

  enum voice_type: {neural2: 0}
  enum ssml_gender: {male: 0, female: 1, neutral: 2}

  def short_code
    self.language.short_code
  end
end
