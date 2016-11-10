class GamesController < ApplicationController
  
  def new
    game = Game.new(hero_reputation: rand(100))
    game.npcs.build(name: Faker::Name.name, personality: rand(100))
    if game.save
      render json: game.to_json(:include => :npcs)
    end
  end

  def talk
    npc = Game.find(params[:id]).npcs.last
    npc.responses.build(input: talk_params[:input])
    if npc.save
      render json: npc.responses.last.to_json
    else 
      render json: npc.errors.to_json
    end
  end

  private
  
  def talk_params
    params.require(:talk).permit(:input)
  end

end
