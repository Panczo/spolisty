class ChartsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user
  

  def create
    if @user.generateChart
<<<<<<< HEAD:app/controllers/charts_controller.rb
      chart = @user.charts.create(generated_at: Time.now, name: 'troorl')
      @user.save
=======
      @user.charts.create(generated_at: Time.now, name: 'test')
>>>>>>> spotify_genre:app/controllers/charts_controller.rb
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
