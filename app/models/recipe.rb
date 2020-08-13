class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users_commented, through: :comments, source: :user

end
