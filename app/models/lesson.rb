class Lesson < ActiveRecord::Base
    belongs_to :user
    belongs_to :category
    has_many :lesson_words, dependent: :destroy
    validates :user_id, presence: true
    validates :category_id, presence: true


end
