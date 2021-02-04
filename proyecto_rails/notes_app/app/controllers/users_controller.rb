class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @users = User.all
    end

end
