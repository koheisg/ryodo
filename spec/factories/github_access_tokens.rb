FactoryGirl.define do
  factory :github_access_token do
    user
    access_token "abc"
    scope "scope1"
    token_type "A"
  end
end
