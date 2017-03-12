FactoryGirl.define do
  factory :github_access_token do
    user_id 1
    access_token "abc"
    scope "scope1"
    token_type "A"
  end
end
