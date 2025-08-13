class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true

  before_validation :set_user_from_question

  validates :content, presence: true

  private
  def set_user_from_question
    self.user ||= question.quiz.user if question && question.quiz
  end
end
