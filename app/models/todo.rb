class Todo < ActiveRecord::Base
  belongs_to :todo_list
  belongs_to :user

  before_validation { |t| t.title.try(:strip!) }
  validates :title, presence: true, length: { maximum: 255 }
  validates :todo_list, presence: true

  scope :completed, -> (status) { where(is_completed: status) }
  scope :belonging_to, -> (user_id) { where(user_id: user_id) }
end
