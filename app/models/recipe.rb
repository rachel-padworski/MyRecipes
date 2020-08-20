class Recipe < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users_commented, through: :comments, source: :user

  def self.create_recipes(recipes)
    recipe = self.create(
      title: recipes["hits"]["recipe"]["label"],
      description: recipes["hits"]["recipe"]["url"],
      image: recipes["hits"]["recipe"]["image"]
    )
  end


end

    #url to the recipe instructions:
    # recipes["hits"][0]["recipe"]["url"]

    #to the recipe title:
    # recipes["hits"][0]["recipe"]["label"]

    #to the recipe image:
    # recipes["hits"][1]["recipe"]["image"]


# get search query from the user
# find recipes that match
# send them to the user

# (...if i have time) user can save a recipe to their "cookbook"