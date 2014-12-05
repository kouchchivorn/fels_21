class Lesson < ActiveRecord::Base
    belongs_to :user
    belongs_to :category
    has_many :lesson_words, dependent: :destroy
    accepts_nested_attributes_for :lesson_words
    validates :user_id, presence: true
    validates :category_id, presence: true


end
