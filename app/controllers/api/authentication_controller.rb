module Api
  class AuthenticationController < ApplicationController
    def login
      render 'api/authentication/error', status: 403 unless user_valid?
    end

    private

    def user_valid?
      @user = User.find_by(email: params[:email])

      return false if @user.nil?

      @user.valid_password?(params[:password])
    end
  end
end
