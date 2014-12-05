FactoryGirl.define do
  factory :user do
    name "Michel Hartl"
    email "michel@examle.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
