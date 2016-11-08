class Response < ApplicationRecord
  include Analyzable
  belongs_to :npc
  after_initialize :analyze_and_decide

 def analyze_and_decide
  rep = self.npc.game.hero_reputation
  personality = self.npc.personality
  @analysis = make_analysis(rep, personality, input)
 end

end 

