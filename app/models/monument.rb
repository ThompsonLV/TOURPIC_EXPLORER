class Monument < ApplicationRecord
  has_many :questions
  has_many :user_monuments
  # validates :photos, presence: true
  validates :title, presence: true
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
