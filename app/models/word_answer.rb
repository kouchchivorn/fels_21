class WordAnswer < ActiveRecord::Base
    has_many :lesson_words
    belongs_to :word

    validates_presence_of :content, :word_id

    scope :correct, -> { where("correct = true").first}

    def to_s
        content
    end
end
