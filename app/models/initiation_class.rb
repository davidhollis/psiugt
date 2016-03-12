class InitiationClass < ActiveRecord::Base
  has_many :members
  
  default_scope -> { order('created_at DESC') }
end
