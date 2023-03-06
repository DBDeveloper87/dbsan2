class CueBlock < ApplicationRecord
  belongs_to :text_track

  attribute :current_block
  attribute :insert_position

  serialize :payload

  enum :cue_type, { subtitles_and_captions: 0,
                    chapters: 1,
                    visual_descriptions: 2,
                    person_distinctions: 3,
                    links: 4 }

  def video
    self.text_track.video
  end
end
