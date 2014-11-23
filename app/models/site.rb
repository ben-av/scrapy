class Site < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_uniqueness_of :base_url
  
  validates :name, presence: true
  validates :base_url, presence: true
end
