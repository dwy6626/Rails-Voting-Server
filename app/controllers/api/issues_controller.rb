module Api
  class IssuesController < ApplicationController
    before_action :authenticate_token!, only: :update
    before_action :set_issue, except: :index

    def index
      @issues = Issue.includes(:votes)
    end

    def show; end

    def update
      current_user.vote!(@issue, true_value?(params[:agree]))
      render :show
    end

    private

    def set_issue
      @issue = Issue.find(params[:id])
    end
  end
end
