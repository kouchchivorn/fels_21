class ActivitiesController < ApplicationController
    def index
        @lessons = current_user.lessons.order(updated_at: :desc).paginate page: params[:page], per_page: 20
    end
end
