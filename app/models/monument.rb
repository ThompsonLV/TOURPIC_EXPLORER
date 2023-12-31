class Monument < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :user_monuments, dependent: :destroy
  has_many :users, through: :user_monuments
  # validates :photos, presence: true
  validates :title, presence: true
  # validates :address, presence: true
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
