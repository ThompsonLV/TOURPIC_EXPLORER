class UserMonument < ApplicationRecord
  belongs_to :user
  belongs_to :monument
  has_many_attached :photos
end
