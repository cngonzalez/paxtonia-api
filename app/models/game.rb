class Game < ApplicationRecord
  has_many :npcs
  has_many :turns

  def next_step(response)
    response.pass ? nil : self.npcs.build(name: Faker::Name.name, personality: rand(100))
    self.save
  end

end
