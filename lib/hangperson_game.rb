class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  #def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError if !letter || letter.empty? || !(letter =~ /[a-z]/i)
    
    letter.downcase!
    if @guesses.include? letter or @wrong_guesses.include? letter
      return false
    end
    if word.include? letter
       @guesses += letter
     else
       @wrong_guesses += letter 
    end
    true
  end
  
  def word_with_guesses
    result = ''
    @word.chars do |letter|
      result += (@guesses.include? letter)? letter : '-'
    end
    result
  end
  
  def check_win_or_lose
    guessed_word = self.word_with_guesses
    return :win if @word == guessed_word
    return :lose if @wrong_guesses.length >= 7 && @word != guessed_word
    return :play 
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
