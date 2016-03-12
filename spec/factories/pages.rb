FactoryGirl.define do
  factory :page do
    title "MyString"
    slug ""
    published_on "2016-03-12 16:34:24"
    body "MyText"
    sidebar "MyText"
    include_in_menu false
    parent nil
  end
end
