FactoryBot.define do

  factory :image do  
    image         {File.open("#{Rails.root}/public/uploads/image/image/1/a004.png")}
  end

end