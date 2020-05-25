FactoryBot.define do

  factory :user do
    nickname          {Faker::Movies::HarryPotter.character}
    email             {Faker::Internet.free_email}
    password          {Faker::Internet.password(min_length: 7)}
    last_name         {Faker::Name.last_name}
    first_name        {Faker::Name.first_name}
    last_name_kana    {Faker::Name.last_name}
    first_name_kana   {Faker::Name.first_name}
    birthdate_year    {"1"}
    birthdate_month   {"1"}
    birthdate_day     {"1"}
  end

end