class TextTrack < ApplicationRecord
  belongs_to :video
  belongs_to :language
  has_many :cue_blocks, dependent: :destroy
  attribute :file_import
  
  enum :status, { draft: 0, published: 0 }

  def process_import(file)
    blocks = file.split(/\r\n\r\n|\n\n/).map{ |s| s.split(/\r\n|\n/) }

    if blocks[0].map { |a| a[0] == "WEBVTT" } then
      blocks.shift
    end

    blocks.each_with_index do |block, i|
      length = block.length - 1

      if block[0].to_i > 0
        cue_num = block[0].to_i
      elsif block[0].to_i == 0 and block[0].include?(" --> ")
        timeline = 0
      else
        comment = 0
        cue_num = i + 1
      end

      if timeline == 0
        sections = block[0].split(" ")
        start_time = sections[0]
        end_time = sections[2]
        payload = block.slice(1, length)
      else
        sections = block[1].split(" ")
        start_time = sections[0]
        end_time = sections[2]
        payload = block.slice(2, length)
      end

      if start_time.include?(",")
        start_time = start_time.gsub(",", ".")
      end

      if end_time.include?(",")
        end_time = start_time.gsub(",", ".")
      end
          
      cue = self.cue_blocks.create([
        cue_num: cue_num,
        cue_type: 0,
        cue_comment: comment,
        start: Time.zone.strptime(start_time, "%H:%M:%S.%L"),
        end: Time.zone.strptime(end_time, "%H:%M:%S.%L"),
        payload: payload,
        sdh: false
      ])
    end
  end

  def create_vtt
    captions = self.cue_blocks.where(cue_type: "subtitles_and_captions").all.order(cue_num: :asc)
    vtt = ["WEBVTT\n\n"]
    captions.each_with_index do |b, i|
      vtt.append("#{i + 1}\n")
      vtt.append("#{b.start.strftime('%H:%M:%S.%L')} --> #{b.end.strftime('%H:%M:%S.%L')}\n")
      unless b.payload.nil?
        b.payload.each do |p|
          vtt.append("#{p}\n")
        end
      end
      vtt.append("\n")
    end

    self.captions = vtt.join("")
    self.save
  end
end
