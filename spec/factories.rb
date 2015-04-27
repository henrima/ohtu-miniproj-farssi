FactoryGirl.define do

  factory :entry do
    category "ARTICLE"
    
    #fields = [field2, field1]
  end

  factory :field do
    name "title"
    content "otsikko"
  end

end