class Zoo < ActiveRecord::Base
  has_many :animals

  def as_json options={}
    super options.merge(include: :animals)
  end
end
