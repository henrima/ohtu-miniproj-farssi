require 'rails_helper'

RSpec.describe "fields/show", type: :view do
  before(:each) do
    @field = assign(:field, Field.create!(
      :name => "Name",
      :content => "MyText",
      :entry_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
  end
end
