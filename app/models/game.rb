class Game < ApplicationRecord
  has_many :npcs
  has_many :turns

  def next_step(response)
    response.pass ? nil : self.npcs.build(name: Faker::Name.name, personality: rand(100))
    self.save
  end

  def hero_deck
    case self.hero_reputation
      when (0..20) then "lower than dirt"
      when (21..40) then "a lovable scoundrel"
      when (41..60) then "completely middle-of-the-road"
      when (61..80) then "more than decent"
      when (81..100) then "disgustingly perfect"
    end
  end

end
