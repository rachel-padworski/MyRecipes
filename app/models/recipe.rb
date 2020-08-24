class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users_commented, through: :comments, source: :user

  validates :content, :title, presence: true

  scope :alpha, -> { order(:title) }

  def self.create_recipes(recipes)
    create(
      title: recipes["hits"]["recipe"]["label"],
      description: recipes["hits"]["recipe"]["url"],
      image: recipes["hits"]["recipe"]["image"]
    )
  end


end

   

