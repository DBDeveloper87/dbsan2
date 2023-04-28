class SurveyQuestion < ApplicationRecord
  belongs_to :survey_section

  enum question_type: {single_choice: 0,
                        multiple_choice: 1,
                        short_answer: 2,
                        long_answer: 3,
                        yes_no: 4,
                        true_false: 5,
                        rating: 6
                      }
end
