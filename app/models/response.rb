class Response < ApplicationRecord
  include Analyzable
  belongs_to :turn
  after_initialize :analyze_and_decide

 def analyze_and_decide
  rep = self.turn.game.hero_reputation
  personality = self.turn.npc.personality
  analysis = make_analysis(rep, personality, input)
  analysis == 1 ? informative : rude
  self.turn.alter_ego(score_input(input))
  self.turn.update(input: self.input, content: self.content) 
 end

 def informative
  self.pass = true
  talk = get_info
  keywords = find_keywords(input, talk["information"].keys)
  if !keywords.empty?
    construct_content(keywords, talk["information"])
  else
    self.content = talk["smalltalk"].sample
  end 
 end

 def rude
   self.pass = false
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

