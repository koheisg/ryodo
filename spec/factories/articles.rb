FactoryGirl.define do
  factory :article do
    user
    title "Title"
    content "# Hello"
    published true
  end
end
