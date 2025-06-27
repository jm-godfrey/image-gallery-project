class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Disabling caching will prevent sensitive information being stored in the
  # browser cache. If your app does not deal with sensitive information then it
  # may be worth enabling caching for performance.
  before_action :update_headers_to_disable_caching

  # always calls this method to check permitted params if working with devise, login/out.
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Tells Rails to use this method to decide which layout to use when rendering a page
  layout :layout_by_resource

  private
    def update_headers_to_disable_caching
      response.headers['Cache-Control'] = 'no-cache, no-cache="set-cookie", no-store, private, proxy-revalidate'
      response.headers['Pragma'] = 'no-cache'
      response.headers['Expires'] = '-1'
    end

    def layout_by_resource
      if devise_controller? && resource_name.in?([:user]) && action_name.in?(%w[new create edit])
        "devise"
      else
        "application"
      end
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
end
