require 'rails_helper'

RSpec.describe "rewiews/show", type: :view do
  before(:each) do
    @rewiew = assign(:rewiew, Rewiew.create!(
      :rating => 1,
      :comment => "MyText",
      :user_id => 2,
      :playlist_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
