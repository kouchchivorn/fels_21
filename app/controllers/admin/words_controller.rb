class Admin::WordsController < Admin::AdminController
    before_action :admin_sign_in
    before_action :set_word, except: [:index, :new, :create]

    def new
        @word = Word.new
        4.times {@word.word_answers.build}
    end

    def index
        if params[:category_id].blank?
            @words = Word.search(params[:content]).paginate page: params[:page], per_page: 20
        else
            category = Category.find(params[:category_id])
            @words = category.words.search(params[:content]).paginate page: params[:page], per_page: 20
        end
    end

    def show
    end

    def edit
    end

    def update
        if @word.update_attributes word_params
            count = 0
            @word.word_answers.each do |word_answer|
                if count < 4
                    word_answer.destroy
                    count = count + 1
                end
            end
            @word.update_attribute(:updated_at, Time.now)
            flash[:success]="Updated successfully!"
            redirect_to admin_words_path
        else
            render "edit"
        end
    end

    def create
        @word = Word.new word_params
        if @word.save
            flash[:success] = "A new word has been created."
            redirect_to admin_words_path
        else
            render "edit"
        end
    end

    def destroy
        if @word.destroy
            flash[:success] = "The word has been deleted."
            redirect_to admin_words_path
        end
    end

    private
        def word_params
            params.require(:word).permit(:content, :category_id,
                            word_answers_attributes: [:content, :correct])
        end

        def set_word
            @word = Word.find params[:id]
        end
end
