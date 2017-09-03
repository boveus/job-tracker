FactoryGirl.define do
  factory :contact do
    name "MyString"
    position "MyString"
    email "MyString"
    references create(:company)
  end
end
