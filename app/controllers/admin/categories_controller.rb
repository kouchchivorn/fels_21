class Admin::CategoriesController < Admin::AdminController
    before_action :admin_sign_in
    before_action :set_category, except: [:index, :new, :create]
    def index
        @categories = Category.search(params[:name])
    end

    def show
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new category_params
        if @category.save
            flash[:success] = "A new category has been added."
            redirect_to admin_categories_path
        else
            render "new"
        end
    end

    def edit
    end

    def update
        if @category.update_attributes category_params
            flash[:success] = "Updated successfully."
            redirect_to admin_categories_path
        else
            render "edit"
        end
    end

    def destroy
        if @category.destroy
            flash[:success] = "The category has been deleted."
            redirect_to categories_path
        end
    end
    private
        def set_category
            @category = Category.find params[:id]
        end

        def category_params
            params.require(:category).permit(:name,:description)
        end
end
