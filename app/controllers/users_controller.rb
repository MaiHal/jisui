class UsersController < ApplicationController
    def signup
        @user = User.new
    end

    def create
        @user = User.new(users_params)
        if @user.save
			redirect_to "/" 
		else
			render 'signup'
		end

    end

    def detail
    end

    def users_params
		params.require(:user).permit(:name, :email, :password)
	end
end
