module Analyzable
  extend ActiveSupport::Concern

  def make_analysis(hero_rep, npc_personality, input)
    score = score_input(input)
    tree = make_tree
    tree.predict([hero_rep, npc_personality, score])
  end

  def make_tree
    tree = DecisionTree::ID3Tree.new(['hero_reputation', 'npc_personality', 'speech_score'], Analyzable.training_data, 1, :continuous)    
    tree.train
    tree
  end

  def configure_text(text)
    text.configure do
      set :stemming, true
      set :upper_case, 2
    end
    text
  end


 def score_input(input)
    whitelist = Highscore::Whitelist.load_file 'app/assets/docs/whitelist.txt'
    blacklist = Highscore::Blacklist.load_file 'app/assets/docs/blacklist.txt'
    text = configure_text(Highscore::Content.new input, blacklist)
    filter = LanguageFilter::Filter.new(matchlist: blacklist.words)
    sanitized = filter.sanitize(text.content).gsub("*", "")
    text2 = configure_text(Highscore::Content.new sanitized)
    keyword_score(text2) + whitelist_score(text, whitelist) + blacklist_score(text, blacklist)
 end

 def keyword_score(text)
   keywords = text.content.keywords
   keywords.rank.collect{|k| k.weight}.inject(0, :+)
 end

 def whitelist_score(text, whitelist)
   keywords = text.content.keywords(whitelist) do
     set :multiplier, 10
     set :stemming, true
     set :upper_case, 1
   end
   keywords.rank.collect {|k| k.weight}.inject(0, :+)end
 
 def blacklist_score(text, blacklist)
  filter = LanguageFilter::Filter.new(matchlist: blacklist.words)
      # sanitized = filter.sanitize(@text.content).gsub(/\s\*{4}\s?/,"")
  filter.matched(text.content).size * -50
 end

def find_keywords(text, array)
  filter = LanguageFilter::Filter.new(matchlist: array)
  # filter2 = LanguageFilter::Filter.new(matchlist: @regex_matches)
  # filter2.matched(@text.content)
  filter.matched(text)
end
  
 def self.training_data
  [
        [rand(66..100), rand(66..100), rand(15..50), 1],
        [rand(66..100), rand(33..66),rand(15..50), 1],
        [rand(66..100), rand(0..33), rand(15..50), 1],
        [rand(66..100), rand(66..100), rand(2..15), 1],
        [rand(66..100), rand(33..66), rand(2..15), 1],
        [rand(66..100), rand(0..33), rand(2..15), 0],
        [rand(66..100), rand(66..100), rand(-100..2), 1],
        [rand(66..100), rand(33..66),rand(-100..2), 0],
        [rand(66..100), rand(0..33), rand(-100..2), 0],
        [rand(33..66), rand(66..100), rand(15..50), 1],
        [rand(33..66), rand(33..66),rand(15..50), 1],
        [rand(33..66), rand(0..33), rand(15..50), 0],
        [rand(33..66), rand(66..100), rand(-100..2), 1],
        [rand(33..66), rand(33..66),rand(-100..2), 0],
        [rand(33..66), rand(0..33), rand(-100..2), 0],
        [rand(0..33), rand(66..100), rand(15..50), 1],
        [rand(0..33), rand(33..66),rand(15..50), 0],
        [rand(0..33), rand(0..33), rand(15..50), 0],
        [rand(0..33), rand(66..100), rand(-100..2), 0],
        [rand(0..33), rand(33..66),rand(2..15), 0],
        [rand(0..33), rand(0..33), rand(2..15), 0]
  ]
 end

end
