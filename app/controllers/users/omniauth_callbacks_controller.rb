class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def spotify
    @user = User.from_omniauth(omnia_hash)
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication 
      set_flash_message(:notice, :success, :kind => "Spotify") if is_navigational_format?
    else
      session["devise.spotify_data"] = omnia_hash.to_yaml
      redirect_to root_path
    end
  end

  protected

  def omnia_hash
    request.env["omniauth.auth"]
  end

  def sign_in_and_redirect(resource_or_scope,resource)
    redirect_to resource_or_scope
  end
end