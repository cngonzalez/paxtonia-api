class GamesController < ApplicationController
  
  def new
    game = Game.new(hero_reputation: rand(100))
    game.save
    game.npcs.build(name: Faker::Name.name, personality: rand(100))
    if game.save
      render json: game.to_json(:include => :npcs)
    else 
      render json: game.errors.to_json
    end
  end

  def talk
    game = Game.find(params[:id])
    npc = game.npcs.last
    turn = game.turns.build(npc: npc)
    resp = turn.build_response(input: talk_params[:input])
    game.next_step(resp)
    if game.save
      render json: turn.to_json
    else 
      render json: game.errors.to_json
    end
  end

  private
  
  def talk_params
    params.require(:talk).permit(:input)
  end

end
