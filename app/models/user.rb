class User < ApplicationRecord
  petergate(roles: [:site_admin], multiple: false)


  has_many :posts
  # Also has many :posts, through: :bookmarks
  has_many :messages
  has_many :contracts
  has_many :bookmarks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   validates_presence_of :name

    def first_name
     self.name.split.first
    end

    def last_name
     self.name.split.last
    end
end
