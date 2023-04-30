class SurveyQuestion < ApplicationRecord
  belongs_to :survey_section
  has_many :question_options
  accepts_nested_attributes_for :question_options, reject_if: :all_blank, allow_destroy: true
  
  before_validation :strip_whitespace
  before_validation :make_nil
  before_validation :join_text

  validates :title, presence: true, on: :update

  enum question_type: {single_choice: 0,
                        multiple_choice: 1,
                        short_answer: 2,
                        long_answer: 3,
                        yes_no: 4,
                        true_false: 5,
                        rating: 6
                      }

  def options
    self.question_options
  end

  private
    def strip_whitespace
      self.title = self.title.strip unless self.title.nil?
      self.description = self.description.strip unless self.description.nil?
    end

    def make_nil
      self.title = nil if self.title == ""
      self.description = nil if self.description == ""
    end

    def join_text
      self.title = self.title.split(/\r\n\r\n|\n\n/).join(" ") unless self.title.nil?
    end
end
