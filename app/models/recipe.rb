class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users_commented, through: :comments, source: :user

  scope :alpha, -> { order(:title) }

  def self.create_recipes(recipes)
    create(
      title: recipes["hits"]["recipe"]["label"],
      description: recipes["hits"]["recipe"]["url"],
      image: recipes["hits"]["recipe"]["image"]
    )
  end


end

   


# get search query from the user
# find recipes that match
# send them to the user

# (...if i have time) user can save a recipe to their "cookbook"