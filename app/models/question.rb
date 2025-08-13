class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers, inverse_of: :question, dependent: :destroy
  
  validates :name, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: ->(attributes) { attributes['content'].blank? }
end
