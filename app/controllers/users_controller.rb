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
        meals = Meal.all
        @sum_price = 0
        meals.each do |meal|
            if meal.meal_date.year == 2018 && meal.meal_date.month == 10
                @sum_price += meal.diff_price.to_i  
            end
        end
    end

    def users_params
		params.require(:user).permit(:name, :email, :password)
	end
end
