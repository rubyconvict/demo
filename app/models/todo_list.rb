class TodoList < ActiveRecord::Base
  has_many :todos, dependent: :destroy
  belongs_to :user

  before_create :generate_slug

  validates :name, presence: true, length: { maximum: 255 }
  validates :user, presence: true
  validates :slug, uniqueness: true

  default_scope { order(id: :desc) }
  
  private

  def generate_slug
    # too long channel name does not work
    self.slug = SecureRandom.hex(12)
  end
end
