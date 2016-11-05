class NpCsController < ApplicationController

def index
  npc = NPC.new(name: Faker::Name.name, personality: rand(100))
  if npc.save
    npc_props = {id: npc.id, name: npc.name, personality: npc.personality}
  end
  render json: npc_props.to_json
end

def wakeup
  render plain: 'i woke up!'
end 


end
