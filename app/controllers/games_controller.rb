class GamesController < ApplicationController
  
  def new
    game = Game.new(hero_reputation: rand(100))
    game.npcs.build(name: Faker::Name.name, personality: rand(100))
    if game.save
      render json: game.to_json(:include => :npcs)
    end
  end
end
