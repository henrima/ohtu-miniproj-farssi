require 'rails_helper'

RSpec.describe Entry, type: :model do
  it "has the category set correctly" do
    entry = Entry.new category:"ARTICLE"

    entry.category.should == "ARTICLE"
  end

  it "has one field set correctly" do
    entry = Entry.new category:"ARTICLE"
    field = Field.new
    field.name = "title"
    field.content = "otsikko"
    entry.fields = [field]

    entry.fields.first.name.should == "title"
    entry.fields.first.content.should == "otsikko"
  end

  it "has two fields set correctly" do
    entry = Entry.new category:"ARTICLE"

    field1 = Field.new
    field1.name = "title"
    field1.content = "otsikko"

    field2 = Field.new
    field2.name = "author"
    field2.content = "jussi"

    entry.fields = [field2, field1]

    entry.fields.first.name.should == "author"
    entry.fields.first.content.should == "jussi"
    entry.fields.last.name.should == "title"
    entry.fields.last.content.should == "otsikko"
  end
end
