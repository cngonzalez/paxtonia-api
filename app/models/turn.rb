class Turn < ApplicationRecord
  belongs_to :game
  has_one :npc
  has_one :response
  after_initialize :build_status

  def alter_ego(points)
    if points >= 20
      self.game.update(hero_reputation: self.game.hero_reputation += (input/20))
      self.result = "#{self.npc.name} thinks you're great! Your reputation has improved in this town. You are now #{self.game.hero_deck}."
    elsif points < 0
      self.game.update(hero_reputation: self.game.hero_reputation -= 10)
      self.result = "#{self.npc.name} thinks you're awful and refuses to speak to you anymore! Your reputation has decreased in this town. You are now #{self.game.hero_deck}."
    else
      self.result = "#{self.npc.name} remains indifferent. You remain #{self.game.hero_deck}"
    end
  end

  def build_status
    self.status = "You approach a #{self.npc.temperament} person named #{self.npc.name}"
  end

end
