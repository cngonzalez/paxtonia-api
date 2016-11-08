class Response < ApplicationRecord
  include Analyzable
  belongs_to :npc
  after_initialize :analyze_and_decide

 def analyze_and_decide
  rep = self.npc.game.hero_reputation
  personality = self.npc.personality
  analysis = make_analysis(rep, personality, input)
  # analysis == 1 ? informative : rude
  informative  
 end

 def informative
  information_file = File.read('app/assets/docs/talk.json')
  talk = JSON.parse(information_file)
  keywords = find_keywords(input, talk["information"].keys)
  if !keywords.empty?
    self.content = keywords.map{|key| talk[key]}.join(" And ")
    npc.game.hero_reputation += score_input(input)/20 if score_input(input) > 20
    self.save
    self.npc.game.save
    self.content += "\n Your ego has been inflated!"
  end
 end

end 

