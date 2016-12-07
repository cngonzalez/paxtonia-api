class Npc < ApplicationRecord
  belongs_to :game
  belongs_to :turn
  has_many :responses

  def temperament
    case self.personality
      when (0..20) then "brutally hostile"
      when (21..40) then "rather unpleasant"
      when (41..60) then "somewhat suspicious"
      when (61..80) then "carefree"
      when (81..100) then "hysterically happy"
    end
  end

end
