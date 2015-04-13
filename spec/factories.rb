FactoryGirl.define do

  factory :animal do
    name "I r Aminal"
    zoo
  end

  factory :zoo do
    name 'Zooooooooo'

    factory :zoo_with_animals do
      transient do
        animals_count 3
      end

      after(:create) do |zoo, e|
        FactoryGirl.create_list(:animal, e.animals_count, zoo: zoo)
      end
    end

  end

  factory :tag do
    value 'Ulam'
  end

end
