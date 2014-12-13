class Admin::WordAnswersController < Admin::AdminController
    def destroy
        @word_answer = WordAnswer.find params[:id]
        @word_answer.destroy
    end
end
