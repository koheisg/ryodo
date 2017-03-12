FactoryGirl.define do
  factory :article do
    user
    title "Title"
    content "This is the content."
    published true
  end
end
