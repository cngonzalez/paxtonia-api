class Game < ApplicationRecord
  has_many :npcs

  def alter_ego(points)
    if points >= 20
      self.update(hero_reputation: hero_reputation += (input/20))
    elsif points < 0
      self.update(hero_reputation: hero_reputation -= 10)
    end
  end

  def next_step(response)
    response.pass ? nil : self.npcs.build(name: Faker::Name.name, personality: rand(100))
    self.save
  end

end
