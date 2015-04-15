require 'rails_helper'

RSpec.describe Field, type: :model do
  it "has the category set correctly" do
    field = Field.new 
    field.name = "title"
    field.content = "otsikko"

    field.name.should == "title"
    field.content.should == "otsikko"
  end
end
