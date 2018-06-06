class HangpersonGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # displays the word after guesses
  def word_with_guesses
    result = ''
    @word.split('').each do |char|
      result << if @guesses.include?(char)
                  char
                else
                  '-'
                end
    end

    result
  end

  # checking winning conditions
  def check_win_or_lose
    if word_with_guesses == @word.downcase
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end


  end

  # make a guess
  def guess(letter)
    if letter =~ /^[A-Z]+$/i && !letter.empty?

      letter.downcase!

      if @guesses.include?(letter) || @wrong_guesses.include?(letter)
        return false
      end

      if @word.include?(letter)
        @guesses << letter
      else
        @wrong_guesses << letter
      end
    else
      raise ArgumentError
    end
  end

  # Get a word from remote "random word" service
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start do |http|
      return http.post(uri, '').body
    end
  end
end
