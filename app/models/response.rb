class Response < ApplicationRecord
  include Analyzable
  belongs_to :npc
  after_initialize :analyze_and_decide

 def analyze_and_decide
  rep = self.npc.game.hero_reputation
  personality = self.npc.personality
  analysis = make_analysis(rep, personality, input)
  analysis == 1 ? informative : rude
 end

 def informative
  talk = get_info
  keywords = find_keywords(input, talk["information"].keys)
  if !keywords.empty?
    construct_content(keywords, talk["information"])
  else
    self.content = talk["smalltalk"].sample
  end 
  npc.game.alter_ego(score_input(input))
 end

 def rude
   self.content = get_info["curses"].sample 
 end

 def get_info
  information_file = File.read('app/assets/docs/talk.json')
  JSON.parse(information_file)
 end

 def construct_content(keywords, talk)
  if keywords.length > 1
     self.content = keywords.map{|key| talk[key]}.join(" And ")
  else 
    self.content = talk[keywords[0]]
  end
 end

end 

