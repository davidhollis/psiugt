class Post < ActiveRecord::Base
  self.per_page = 10
  
  scope :published, -> { where(published: true) }
end
