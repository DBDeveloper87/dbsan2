class Photo < ApplicationRecord
  after_create_commit :set_exif
  serialize :exif

  belongs_to :product_image_set
  has_one_attached :file
  
  def shot_on
    if self.exif["Make"].present?
      "#{self.exif["Make"]} #{self.exif["Model"]}"
    else
      "Unknown"
    end
  end

  def latitude
    if self.exif["GPSLatitude"].present?
      lat = self.exif["GPSLatitude"]
      lat = lat.split(", ")
      deg = lat[0].split("/")
      degrees = (deg[0].to_f / deg[1].to_f).to_i
      min = lat[1].split("/")
      minutes = (min[0].to_f / min[1].to_f).to_i
      sec = lat[2].split("/")
      seconds = (sec[0].to_f / sec[1].to_f)
      direction = self.exif["GPSLatitudeRef"]
      dir = nil

      if direction == "N"
        dir = 1
      else
        dir = -1
      end

      {humanize: "#{degrees}&#176; #{minutes}\' #{seconds}\" #{direction}",
      float: (degrees + (minutes / 60).to_f + (seconds / 3600).to_f * dir) }
    else
      "Unknown"
    end
  end

  def longitude
    if self.exif["GPSLongitude"].present?
      long = self.exif["GPSLongitude"]
      long = long.split(", ")
      deg = long[0].split("/")
      degrees = (deg[0].to_f / deg[1].to_f).to_i
      min = long[1].split("/")
      minutes = (min[0].to_f / min[1].to_f).to_i
      sec = long[2].split("/")
      seconds = (sec[0].to_f / sec[1].to_f)
      direction = self.exif["GPSLongitudeRef"]
      dir = nil
      
      if direction == "W"
        dir = 1
      else
        dir = -1
      end
      
      {humanize: "#{degrees}&#176; #{minutes}\' #{seconds}\" #{direction}", 
      float: (degrees + (minutes / 60).to_f + (seconds / 3600).to_f * dir) }
    else
      "Unknown"
    end
  end

  def altitude
    if self.exif["GPSAltitude"].present?
      alt = self.exif["GPSAltitude"]
      alt = alt.split("/")
      float = (alt[0].to_f / alt[1].to_f)
      feet = float.to_i
      inches = ((float - feet) * 12).round(2)
      "#{feet}\' #{inches}\""
    else
      "Unknown"
    end
  end

  private
    def set_exif
      self.exif = MiniMagick::Image.open(self.file).exif
      self.save
    end
end