class WordsController < ApplicationController
    def new
        @word = Word.new
    end

    def index
        if params[:learn].blank?
            params[:learn] = "all"
        end

        if params[:category_id].blank?
            if params[:learn] == "all"
                @words = Word.paginate page: params[:page], per_page: 20
            elsif params[:learn] == "learned"
                @words = Word.learned(current_user.id, params[:category_id])
                .paginate page: params[:page], per_page: 20
            else
                @words = Word.not_learned(current_user.id, params[:category_id])
                .paginate page: params[:page], per_page: 20
            end
        else
            if params[:learn] == "all"
                category = Category.find(params[:category_id])
                @words = category.words.paginate page: params[:page], per_page: 20
            elsif params[:learn] == "learned"
                @words = Word.learned(current_user.id, params[:category_id])
                .paginate page: params[:page], per_page: 20
            else
                @words = Word.not_learned(current_user.id, params[:category_id])
                .paginate page: params[:page], per_page: 20
            end
        end
    end
end
