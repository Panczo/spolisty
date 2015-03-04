class ChartsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user
  

  def create
    if @user.generateChart
      @user.charts.create(generated_at: Time.now, name: 'test')
      flash["success"] = "Successfully generated Chart"
      redirect_to @user
    else
      flash["error"] = "Something goes wrong"
      redirect_to @user
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

end
