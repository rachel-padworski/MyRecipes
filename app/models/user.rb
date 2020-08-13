class User < ApplicationRecord

    has_many :recipes
    has_many :comments
    has_many :recipe_comments, through: :recipes, source: :comments
        #User has\many recipe comments

    has_secure_password #gives us access to built-in validations, authentic method, password confirmation

    validates :email, presence: true
    validates :user_name, presence: true, uniqueness: true
    

end
