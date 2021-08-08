class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true
  validates :priority, presence: true
  validates :deadline, presence: true
  validates :completed, inclusion: { in: [true,false] }
end
