FactoryGirl.define do

  factory :entry do
    category "ARTICLE"
    field1 = Field.new
    field1.name = "title"
    field1.content = "otsikko"

    field2 = Field.new
    field2.name = "author"
    field2.content = "jussi"

    fields = [field2, field1]
  end

  factory :field do
    name "title"
    content "otsikko"
  end

end