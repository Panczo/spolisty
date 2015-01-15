require 'rails_helper'

RSpec.describe PlaylistsController, :type => :controller do
  login_user
  let(:user) { subject.current_user }
  let(:playlist) { create(:playlist, user: user)}

  it "get index" do
    get :index, { user_id: user }

    expect(response).to redirect_to(user_path(user))
  end

  it "should have a current_user" do
    expect(user).to_not be_nil
  end

  it "should show playlist" do
    get :show, id: playlist.id, user_id: user.id

    expect(response).to render_template :show
    expect(assigns(:playlist)).to eq playlist
  end

  context "playlist owner" do
    it 'can delete playlist' do
      delete :destroy, id: playlist.id, user_id: user.id

      expect(response).to redirect_to(user_path(user))
      expect(flash[:success]).to eq("Playlist deleted")
    end
  end

  context "other user" do
    let(:other_user) { create(:user) }
    let(:other_playlist) { create(:playlist, user: other_user) }
    
    it "cant delete user playlist" do
      delete :destroy, id: other_playlist.id, user_id: other_user.id

      expect(response).to redirect_to(user_path(other_user))
      expect(flash[:error]).to eq("You can't delete this playlist")
    end
  end
end
