class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    rescue_from CanCan::AccessDenied do |exception|
		redirect_to main_app.root_path
	end

    def is_employee?
        if current_user.present? then
            Employee.where(user_id: current_user.id).exists?
        else
            false
        end
    end

    helper_method :is_employee?
end
