class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

	def who_are_you
		if params[:id] != current_user.id
			redirect_to books_path
		end
	end

	def after_sign_in_path_for(resource)
		user_path(current_user.id)
	end
	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
	end
end
