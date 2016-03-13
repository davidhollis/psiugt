class MenuItem < ActiveRecord::Base
  belongs_to :page
  
  acts_as_list
end
