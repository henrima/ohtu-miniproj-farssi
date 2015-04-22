require 'rails_helper'

RSpec.describe "fields/new", type: :view do
  before(:each) do
    assign(:field, Field.new(
      :name => "MyString",
      :content => "MyText",
      :entry_id => 1
    ))
  end

  it "renders new field form" do
    render

    assert_select "form[action=?][method=?]", fields_path, "post" do

      assert_select "input#field_name[name=?]", "field[name]"

      assert_select "textarea#field_content[name=?]", "field[content]"

      assert_select "input#field_entry_id[name=?]", "field[entry_id]"
    end
  end
end
