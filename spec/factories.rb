FactoryBot.define do
  factory :user do
    username { "Pekka" }
    password { "Foobar1" }
    password_confirmation { "Foobar1"}
  end

  factory :brewery do
    name { "test_brewery" }
    year { 2000 }
  end

  factory :beer do
    name { "test_beer" }
    style { "Lager" }
    brewery
  end

  factory :rating do
    score { 10 }
    beer
    user
  end
end