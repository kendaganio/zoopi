class Animal < ActiveRecord::Base
  belongs_to :zoo
  has_and_belongs_to_many :tags

  def as_json options={}
    super options.merge(include: :zoo)
  end
end
