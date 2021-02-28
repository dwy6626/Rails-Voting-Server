class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def true_value?(value)
    ActiveModel::Type::Boolean.new.cast(value)
  end

  private

  def render_not_found
    render 'api/404', status: 404
  end

  def authenticate_token!
    user = User.find_by(auth_token: params['auth_token'])
    sign_in(user, store: false) if user
    authenticate_user!
  end
end
