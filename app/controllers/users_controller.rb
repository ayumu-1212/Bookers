class UsersController < ApplicationController

	before_action :authenticate_user!
	before_action :who_are_you_user, only: [:edit, :update]

	def who_are_you_user
		if current_user.id != params[:id].to_i
			redirect_to user_path(current_user)
		end
	end

	def show
		@books = Book.where(user_id: params[:id])
		@book = Book.new
		@user = User.find(params[:id])
	end

	def index
		@users = User.all.order(created: :desc)
		@user = current_user
		@book = Book.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "You have updated user successfully."
			redirect_to user_path(@user.id)
		else
			render :edit
		end
	end

private
	def user_params
		params.require(:user).permit(:name, :profile_image, :introduction)
	end
end
