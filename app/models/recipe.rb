class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users_commented, through: :comments, source: :user

  validates :description, :title, presence: true

  scope :alpha, -> { order('LOWER(title)') }

  def self.search(q)
    Recipe.where("title LIKE ?", "%#{q}%").alpha
  end


end

   

