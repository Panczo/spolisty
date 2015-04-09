require 'rails_helper'

RSpec.describe "rewiews/index", type: :view do
  before(:each) do
    assign(:rewiews, [
      Rewiew.create!(
        :rating => 1,
        :comment => "MyText",
        :user_id => 2,
        :playlist_id => 3
      ),
      Rewiew.create!(
        :rating => 1,
        :comment => "MyText",
        :user_id => 2,
        :playlist_id => 3
      )
    ])
  end

  it "renders a list of rewiews" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
