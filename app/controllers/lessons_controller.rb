class LessonsController < ApplicationController
    def index
        @lessons = current_user.lessons
    end

    def create
        category = Category.find params[:lesson][:category_id]
        @lesson = category.lessons.create(user_id: current_user.id)
        generate_lesson @lesson
        redirect_to @lesson
    end

    def show
        @lesson = Lesson.find params[:id]
    end

    def update
        @lesson = Lesson.find params[:id]
        if @lesson.update_attributes(lesson_param)
            flash[:success] = "Great! lesson completed."
            redirect_to result_path
        else
            flash[:error] = "Sorry, there is an error"
            render "show"
        end
    end

    private
        def lesson_param
            params.require(:lesson).permit(:user_id, :category_id,
                                                    lesson_words_attributes: [:word_answer_id, :id])
        end
        def generate_lesson(lesson)
            @learning_words =lesson.category.words.order("RAND()").limit(20)
            @learning_words.each do |word|
                lesson.lesson_words.create(word_id: word.id)
            end
        end


end
