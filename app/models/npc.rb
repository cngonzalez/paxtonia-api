class Npc < ApplicationRecord
  belongs_to :game
  has_many :responses

end
