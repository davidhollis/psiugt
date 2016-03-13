class Page < ActiveRecord::Base
  belongs_to :parent, class_name: 'Page'
  has_many :children, class_name: 'Page', foreign_key: :parent_id
  
  scope :roots, -> { where(parent: nil) }
  
  validates :slug,
    presence: true,
    uniqueness: true,
    format: { with: /\A[a-z0-9-]+\Z/, message: 'must consist entirely of lower-case letters, numbers, and hyphens (-)' },
    exclusion: { in: %w(admin casein posts), message: '%{value} is a reserved slug' }
  
  def path
    "#{parent&.path}/#{slug}"
  end
end
