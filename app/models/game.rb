class Game < ApplicationRecord
  has_many :npcs

  def inflate_ego(points)
    if points >= 20
      self.update(hero_reputation: hero_reputation += (input/20))
    end
  end

end
