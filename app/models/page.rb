class Page < ActiveRecord::Base
  belongs_to :parent, class_name: 'Page'
  has_many :children, class_name: 'Page', inverse_of: :parent
  
  scope :roots, -> { where(parent: nil) }
  
  validates :slug,
    presence: true,
    uniqueness: true,
    format: { with: /\A[a-z0-9-]+\Z/, message: 'must consist entirely of lower-case letters, numbers, and hyphens (-)' },
    exclusion: { in: %w(admin casein), message: '%{value} is a reserved slug' }
  
  def published?
    published_on and published_on <= Time.now
  end
  
  def path
    "#{parent&.path}/#{slug}"
  end
end
