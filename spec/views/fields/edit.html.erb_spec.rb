require 'rails_helper'

RSpec.describe "fields/edit", type: :view do
  before(:each) do
    @field = assign(:field, Field.create!(
      :name => "MyString",
      :content => "MyText",
      :entry_id => 1
    ))
  end

  it "renders the edit field form" do
    render

    assert_select "form[action=?][method=?]", field_path(@field), "post" do

      assert_select "input#field_name[name=?]", "field[name]"

      assert_select "textarea#field_content[name=?]", "field[content]"

      assert_select "input#field_entry_id[name=?]", "field[entry_id]"
    end
  end
end
