class Monument < ApplicationRecord
  has_many :questions
  has_many :user_monuments
end
