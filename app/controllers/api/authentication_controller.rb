module Api
  class AuthenticationController < ApplicationController
    class EmailTaken < StandardError; end
    class ValidationError < StandardError; end

    rescue_from EmailTaken, with: :render_conflict
    rescue_from ValidationError, with: :render_validation_fail

    def login
      render 'api/authentication/403', status: 403 unless user_valid?
    end

    def create
      raise EmailTaken if User.where(email: params[:email]).any?

      @user = User.new email: params[:email], password: params[:password]
      raise ValidationError unless @user.valid?

      @user.save!
    end

    private

    def render_conflict
      render 'api/409', status: 409
    end

    def render_validation_fail
      render 'api/authentication/400', status: 400
    end

    def user_valid?
      @user = User.find_by(email: params[:email])

      return false if @user.nil?

      @user.valid_password?(params[:password])
    end
  end
end
