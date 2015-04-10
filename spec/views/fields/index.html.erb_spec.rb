require 'rails_helper'

RSpec.describe "fields/index", type: :view do
  before(:each) do
    assign(:fields, [
      Field.create!(
        :name => "Name",
        :content => "MyText",
        :entry_id => 1
      ),
      Field.create!(
        :name => "Name",
        :content => "MyText",
        :entry_id => 1
      )
    ])
  end

  it "renders a list of fields" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
