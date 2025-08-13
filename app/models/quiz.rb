class Quiz < ApplicationRecord
    belongs_to :user
    has_many :questions, inverse_of: :quiz, dependent: :destroy
    before_create :generate_share_token

    accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: ->(attributes) { attributes['name'].blank? }
    
    def to_s
        title
    end

    private
    def generate_share_token
        self.share_token = SecureRandom.hex(10)
    end
end
