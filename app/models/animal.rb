class Animal < ActiveRecord::Base
  belongs_to :zoo

  def as_json options={}
    super options.merge(include: :zoo)
  end
end
