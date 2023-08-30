class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_answers, dependent: :destroy
  has_many :answers, through: :user_answers
  has_many :user_monuments, dependent: :destroy


end
