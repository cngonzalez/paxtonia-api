class GamesController < ApplicationController
  
  def new
    game = Game.new(hero_reputation: rand(100))
    game.npcs.build(name: Faker::Name.name, personality: rand(100))
    if game.save
      render json: game.to_json(:include => :npcs)
    end
  end

  def talk
    game = Game.find(params[:id]
    npc = game.npcs.last
    npc.responses.build(input: talk_params[:input])
    game.turns.build(response: npc.responses.last, npc: npc) 
    game.next_step(npc.responses.last)
    if game.save
      render json: game.turns.last.to_json
    else 
      render json: game.errors.to_json
    end
  end

  private
  
  def talk_params
    params.require(:talk).permit(:input)
  end

end
