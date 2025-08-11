class Quiz < ApplicationRecord
    has_many :questions, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true

    belongs_to :user

    def to_s
        title
    end

end
