class Language < ApplicationRecord
	serialize :lang_type
	before_validation :strip
	
	private
		def strip
			unless self.name.nil?
				self.name = self.name.strip
				if self.name == ""
					self.name = nil
				end
			end

			unless self.dialect.nil?
				self.dialect = self.dialect.strip
				if self.dialect == ""
					self.dialect = nil
				end
			end

			unless self.long_code.nil?
				self.long_code = self.long_code.strip
				if self.long_code == ""
					self.long_code = nil
				end
			end

			unless self.short_code.nil?
				self.short_code = self.short_code.strip
				if self.short_code == ""
					self.short_code = nil
				end
			end
		end
end