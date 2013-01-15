FactoryGirl.define do
  factory :point do
    lonlat { sprintf("POINT(%f %f)", 2.0, 1.0) }
    after(:build) do |point|
      point.payloads << FactoryGirl.build(:payload)
    end
  end
end
