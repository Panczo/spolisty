class Users::SessionsController < Devise::SessionsController
  include ApplicationHelper

  def create
    super
  end

  def new
    super
  end

  def destroy
  	super
  	session["devise.spotify_data"] = nil
  end

end
