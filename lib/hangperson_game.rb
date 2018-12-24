class HangpersonGame


	attr_accessor :word, :guesses, :wrong_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
	@guesses = ''
	@wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  def guess(letter)
  	if not letter 
		raise ArgumentError.new("Letter is Nil")
	end
	if letter.length == 0
		raise ArgumentError.new("Empty Letter")
	end
	result = letter.match("^[a-zA-Z]")
	if not result
		raise ArgumentError.new("Not a Letter")
	end
	
	@word = @word.downcase
	letter = letter.downcase
	if @word.include? letter
		if not @guesses.include? letter
			@guesses += letter
		else
			return false
		end
	else
		if not @wrong_guesses.include? letter
			@wrong_guesses += letter
			
		else
			return false
		end
	end
  
  end
  
  def word_with_guesses
	result = ''
	# Make the string "-----"
	@word.each_char do |c|
		result += '-'
	end
	puts result
	#"Einstein".enum_for(:scan, /(?=in)/).map { Regexp.last_match.offset(0).first }
	
	@guesses.each_char do |c| 
		@word.split("").each_with_index do |val, index| 
			if c == @word[index]
				result[index] = c
			end
		
		end
			
	end
				
	return result
  end
  
  
  def check_win_or_lose
	if wrong_guesses.length >= 7
		return :lose
	
	elsif word_with_guesses == @word
		return :win
		
	else
		return :play
	end
	
		
		
		
  end
  
  
  
  
  
  
  
  
  
  
end
