class CueBlock < ApplicationRecord
  belongs_to :text_track
  has_many :synthesize_speech_clips

  attribute :current_block
  attribute :insert_position
  before_save :make_nil
  after_commit :generate_audio

  serialize :payload

  enum :cue_type, { subtitles_and_captions: 0,
                    chapters: 1,
                    visual_descriptions: 2,
                    person_distinctions: 3,
                    links: 4,
                    paragraph_break: 5 }

  def video
    self.text_track.video
  end

  private
    def generate_audio
      voices = [
        { languageCode: "en-US", voice_name: "en-US-Neural2-D", ssmlGender: "MALE" },
        { languageCode: "en-US", voice_name: "en-US-Neural2-F", ssmlGender: "FEMALE" }
      ]

      ENV["TEXTTOSPEECH_KEYFILE"] = "#{Rails.root.join('google-credentials.json')}"

      unless self.synthesize_text.nil?
        if self.synthesize_speech_clips.count > 0
          self.synthesize_speech_clips.destroy_all
        end
        
        client = Google::Cloud::TextToSpeech.text_to_speech  
      
        voices.each do |v|
          response = client.synthesize_speech(
            input: { text: self.synthesize_text },
            voice: { name: v[:voice_name], language_code: v[:languageCode], ssml_gender: v[:ssmlGender] },
            audio_config: {audio_encoding: 'MP3'}
          )

          File.open("/tmp/#{self.id}_#{v[:voice_name].downcase}.mp3", "wb") do |file|
            file.write response.audio_content
          end

          clip = self.synthesize_speech_clips.create(
            language: Language.find_by(long_code: v[:languageCode].downcase),
            language_code: v[:languageCode],
            voice_name: v[:voice_name],
            ssml_gender: v[:ssmlGender].downcase,
            cue_block_id: self.id
            )

          clip.audio_file.attach(io: File.open("/tmp/#{self.id}_#{v[:voice_name].downcase}.mp3"), filename: "#{self.id}_#{v[:voice_name].downcase}.mp3", content_type: "audio/mpeg")
          clip.save
        
        end
      end
    end

    def make_nil
      if self.synthesize_text == ""
        self.synthesize_text = nil
      end

      if self.ssml == ""
        self.ssml = nil
      end
    end
end
