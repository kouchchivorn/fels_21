module LessonsHelper
    def lesson
        @lesson = Lesson.find params[:id]
    end
end
