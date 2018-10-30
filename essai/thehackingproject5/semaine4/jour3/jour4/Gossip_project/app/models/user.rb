class User < ApplicationRecord
  has_many :gossips
  has_many :comments
  has_many :likes
  has_many :privatemessages
  belongs_to :city
end
