class Word < ActiveRecord::Base
    belongs_to :category
    has_many :word_answers, inverse_of: :word
    has_many :lesson_words
    accepts_nested_attributes_for :word_answers
    validates :category_id, presence: true
    validates :content, presence: true, length: { maximum: 30}

    default_scope {order("updated_at DESC")}

    scope :learned, ->(user_id, category_id) do
        if category_id.blank?
            lesson_ids = Lesson.select(:id).where(user_id: user_id).to_sql
        else
            lesson_ids = Lesson.select(:id).where("user_id= ? AND category_id = ?", user_id, category_id).to_sql
        end

        correct_word_answer_ids = WordAnswer.select(:id).where(correct: true).to_sql
        word_ids = LessonWord.select(:word_id).where("lesson_id IN (#{lesson_ids}) AND  word_answer_id IN (#{correct_word_answer_ids})").to_sql
        Word.where("id IN (#{word_ids})")
    end

    scope :not_learned, ->(user_id, category_id) do

        if  category_id.blank?
            lesson_ids = Lesson.select(:id).where(user_id: user_id).to_sql
            correct_word_answer_ids = WordAnswer.select(:id).where(correct: true).to_sql
            word_ids = LessonWord.select(:word_id)
                          .where("lesson_id IN (#{lesson_ids}) AND word_answer_id NOT IN (#{correct_word_answer_ids})").to_sql
        else
            if Lesson.exists?(user_id: user_id, category_id: category_id)
                lesson_ids = Lesson.select(:id).where("user_id = ? AND category_id = ?", user_id, category_id).to_sql
                correct_word_answer_ids = WordAnswer.select(:id).where(correct: true).to_sql
                word_ids = LessonWord.select(:word_id)
                          .where("lesson_id IN (#{lesson_ids}) AND word_answer_id NOT IN (#{correct_word_answer_ids})").to_sql
            else
                word_ids = Word.select(:id).where(category_id: category_id).to_sql
            end
        end
        Word.where("id IN (#{word_ids})")
    end

    scope :search, ->(content) do
        where("content LIKE ?", "%#{content}%")
    end

    def to_s
        content
    end
end
