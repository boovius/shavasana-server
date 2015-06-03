FactoryGirl.define do
  factory :doing do

    factory :this_week_doing do
      created_at Time.now - 3.days
    end

    factory :previous_week_doing do
      created_at Time.now - 10.days
    end
  end
end
