class Member < ActiveRecord::Base
  belongs_to :initiation_class
  belongs_to :big_brother, class_name: 'Member'
  has_many :little_brothers, class_name: 'Member', inverse_of: :big_brother
  
  enum status: %i(active candidate alum withdrawn)
  
  scope :biggable, -> { where.not(status: statuses['candidate']).order(:name) }
  
  ATTRIBUTES = %w(founder honorary)
end
