require 'rails_helper'

RSpec.describe "entries/index", type: :view do
  before(:each) do
    assign(:entries, [
      Entry.create!(
        :category => "Category"
      ),
      Entry.create!(
        :category => "Category"
      )
    ])
  end

  it "renders a list of entries" do
    render
    assert_select "tr>td", :text => "Category".to_s, :count => 2
  end
end
