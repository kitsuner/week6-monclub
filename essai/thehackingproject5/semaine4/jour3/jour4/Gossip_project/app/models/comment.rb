class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :gossip
  has_many :comments
end
