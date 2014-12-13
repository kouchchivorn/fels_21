class Admin::UsersController < Admin::AdminController
    before_action :admin_sign_in
    before_action :set_user, except: [:index, :new, :create]

    def index
        @users = User.search(params[:name]).paginate page: params[:page], per_page: 20
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            sign_in @user
            flash[:success] = "Welcome to Blog"
            redirect_to admin_users_path
        else
            render "new"
        end
  end

    def show
    end

    def edit
    end

    def update
        if @user.update user_params
            flash[:success] = "Profile has been successfully updated!"
            redirect_to admin_user_path @user
        else
            render "edit"
        end
    end

    def destroy
        if @user.destroy
            flash[:success] = "A user has been deleted."
            redirect_to admin_users_path
        end
    end
    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

        def set_user
            @user = User.find params[:id]
        end
end
