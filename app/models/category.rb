class Category < ApplicationRecord
  has_many :tasks

  validates :name, presence: true
  validates :image_url, presence: true
end
