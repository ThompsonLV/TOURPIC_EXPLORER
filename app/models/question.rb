class Question < ApplicationRecord
  belongs_to :monument
  has_many :answers
end
