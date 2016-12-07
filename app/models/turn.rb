class Turn < ApplicationRecord
  belongs_to :game
  has_one :npc
  has_one :response
  after_initialize :build_status

  def alter_ego(points)
    if points >= 20
      self.game.update(hero_reputation: hero_reputation += (input/20))
    elsif points < 0
      self.game.update(hero_reputation: hero_reputation -= 10)
    else 
    end
  end

  def build_status
    self.status = "You approach a #{self.npc.temperament} person named #{self.npc.name}"
  end

end
