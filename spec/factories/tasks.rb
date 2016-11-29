FactoryGirl.define do
  factory :task do
    title 'MyString'
    association :creator, factory: :user, strategy: :build
  end
end
