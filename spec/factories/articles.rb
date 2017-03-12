FactoryGirl.define do
  factory :article do
    user_id 1
    title "Title"
    content "This is the content."
    published true
  end
end
