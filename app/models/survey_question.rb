class SurveyQuestion < ApplicationRecord
  belongs_to :survey_section
  has_many :question_options, dependent: :destroy
  accepts_nested_attributes_for :question_options, reject_if: :all_blank, allow_destroy: true
  has_many :response_answers, dependent: :destroy
  

  before_validation :strip_whitespace
  before_validation :make_nil
  before_validation :join_text
  after_create :perform_option_generation
  before_destroy :update_positions
  #validates :title, presence: true, on: :update

  enum question_type: {single_choice: 0,
                        multiple_choice: 1,
                        short_answer: 2,
                        long_answer: 3,
                        yes_no: 4,
                        true_false: 5,
                        rating: 6,
                        name_fields: 7,
                        email_address: 8,
                        county_select: 9
                      }

  def options
    self.question_options
  end

  def section
    self.survey_section
  end

  private
    def perform_option_generation
      if self.question_type == "county_select"
        state = StateProvince.find_by(name: "Minnesota")
        counties = state.counties.order(name: :asc).all
        counties.each do |c|
          self.options.create(name: c.name)
        end
      elsif self.question_type == "yes_no"
        self.options.create(name: "Yes")
        self.options.create(name: "No")
      elsif self.question_type == "name_fields"
        self.options.create(name: "First Name")
        self.options.create(name: "Last Name")
      elsif self.question_type == "email_address"
        self.options.create(name: "Email Address")
      end
    end

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

    def update_positions
      questions = self.section.questions
      questions[self.position..questions.count-1].each do |q|
        q.position = q.position-1
        q.save
      end
    end
end
