class Category < ApplicationRecord
  has_many :tasks
  belongs_to :user

  validates :name, presence: true
  validates :image_url, presence: true
end
