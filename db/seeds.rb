# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Create Category
Category.create!(name: "Basic 500")
Category.create!(name: "At a Restaurant")
Category.create!(name: "On a Trip")

#Create Word
3.times do |m|
    60.times do |n|
        word = "Japanese#{m+1}_#{n+1}"
        Word.create!(content: word, category_id: m+1)
    end
end

#Create WordAnswer
words = Word.order(:created_at).all
3.times do |k|
    60.times do |m|
        word_id = 60 * k + m
        correct = rand(1..4)
        4.times do |n|
            str_correct = (n +1 == correct ? true : false)
            WordAnswer.create!(content: "English#{k+1}_#{m+1}_#{n+1}_#{str_correct}",
                                                word_id: word_id +1,
                                                correct: str_correct)
        end
    end
end

#Create User
User.create!(name: "Kouch Chivorn",
                      email: "kouchchivorn5@yahoo.com",
                      password: "123456",
                      password_confirmation: "123456")



#Create Lesson, when starting lessons in a category every words
# of which must be used, in which lessonwords are created instantly
# afterward and word_answer_id is set to NULL by default

2.times do |n|
    3.times do |m|
        user_id = 1
        category_id = n +1
        result = rand(16..20)
        Lesson.create!(user_id: user_id,
                                  category_id: category_id,
                                  result: result)
    end
end

#Create LessonWord
2.times do |n|  # create lesson for the first two categories
    60.times do |k|
        lesson_id = 3 * n+ k/20 +1
        word_id = n * 60 + k +1
        if lesson_id % 3 != 0
            if k + rand(0..3) == k
                word_answer_id = WordAnswer.find_by(word_id: word_id, correct: false).id
            else
                word_answer_id = WordAnswer.find_by(word_id: word_id, correct: true).id
            end
        else
            word_answer_id = nil
        end
        LessonWord.create!(lesson_id: lesson_id,
                                           word_id: word_id,
                                           word_answer_id: word_answer_id)
    end
end




