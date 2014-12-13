class StaticPagesController < ApplicationController
    def home
     @lessons = current_user.lessons.order(updated_at: :desc)
                        .paginate page: params[:page], per_page: 20 if current_user
    end

end
