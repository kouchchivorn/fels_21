class ResultsController < ApplicationController
    def index
        @lessons = current_user.lessons
    end

    def show
        @lesson = Lesson.find params[:id]
    end
end
