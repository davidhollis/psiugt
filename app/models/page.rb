class Page < ActiveRecord::Base
  belongs_to :parent, class_name: 'Page'
  has_many :children, class_name: 'Page', foreign_key: :parent_id
  
  scope :roots, -> { where(parent: nil) }
  
  validates :slug,
    presence: true,
    uniqueness: { scope: :parent },
    format: { with: /\A[a-z0-9-]+\Z/, message: 'must consist entirely of lower-case letters, numbers, and hyphens (-)' },
    exclusion: { in: %w(admin casein posts), message: '%{value} is a reserved slug' }
  
  def path
    "#{parent&.path}/#{slug}"
  end
  
  def slug_path
    (parent &.path || []) + [self.slug]
  end
  
  class << self
    def home
      roots.find_or_create_by(slug: 'home') do |page|
        page.published = false
        page.title = 'Home'
        page.body = ''
      end
    end
    
    def not_found
      roots.find_or_create_by(slug: '404') do |page|
        page.published = false
        page.title = 'Page Not Found'
        page.body = FALLBACK_PAGE_BODY
      end
    end
  end
  
  FALLBACK_PAGE_BODY = "<h2>Page not found</h2><p>The page you were looking for couldn't be found.</p>"
end
