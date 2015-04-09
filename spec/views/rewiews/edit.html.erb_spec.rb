require 'rails_helper'

RSpec.describe "rewiews/edit", type: :view do
  before(:each) do
    @rewiew = assign(:rewiew, Rewiew.create!(
      :rating => 1,
      :comment => "MyText",
      :user_id => 1,
      :playlist_id => 1
    ))
  end

  it "renders the edit rewiew form" do
    render

    assert_select "form[action=?][method=?]", rewiew_path(@rewiew), "post" do

      assert_select "input#rewiew_rating[name=?]", "rewiew[rating]"

      assert_select "textarea#rewiew_comment[name=?]", "rewiew[comment]"

      assert_select "input#rewiew_user_id[name=?]", "rewiew[user_id]"

      assert_select "input#rewiew_playlist_id[name=?]", "rewiew[playlist_id]"
    end
  end
end
