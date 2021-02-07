class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
  end

  # GET /users/1/export_all_notes
  def export_all_notes
    @books = @user.books
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

end
