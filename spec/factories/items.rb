FactoryBot.define do


  factory :category do
    name {"hoge"}
  end
  
  factory :item do  
    name              {Faker::Movie.quote}
    price             {'10000'}
    explanation       {Faker::Lorem.sentence}
    category_id       {3}
    item_size_id      {2}
    condition_id      {1}
    shipping_fee_id   {1}
    shipping_day_id   {1}
    prefecture_id     {1}
    user
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    updated_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end

  trait :with_image do
    after(:build){|item| item.images << FactoryBot.build(:image)}
  end

end