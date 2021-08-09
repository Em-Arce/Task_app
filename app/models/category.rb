class Category < ApplicationRecord
  has_many :tasks , dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :image_url, presence: true
end
