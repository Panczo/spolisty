require 'rails_helper'

RSpec.describe PlaylistsController, :type => :controller do
  login_user
  it "should have a current_user" do
    expect(subject.current_user).to_not be_nil
  end

  context "playlist owner" do
    let(:user) { subject.current_user }
    let(:playlist) { create(:playlist, user: user)}
    it 'can delete playlist' do
      delete :destroy, id: playlist.id, user_id: user.id

      expect(response).to redirect_to(user_path(user))
    end
  end
end
