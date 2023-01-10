class Hangman
  def initialize()
    @word = get_word
    @guesses_remaining = 7
    @solution = []
    create_solution_display
    @guesses = []
  end

  def get_word
    dictionary = IO.readlines("./dictionary.txt")
    word = dictionary[rand(0..dictionary.length)].chop
    until word.length >= 5 && word.length <= 12 do
      word = dictionary[rand(0..dictionary.length)].chop
    end
    return word
  end

  def create_solution_display
    ch_array = @word.split('')
    ch_array.each { @solution.push("_") }
  end

  def play_game
    display_game_info
    current_guess = get_guess
  end
  
  def display_game_info
    puts @word
    puts @solution.join(" ")
    puts "You have #{@guesses_remaining} guesses remaining"
    guess_string = @guesses.join(",")
    puts "Your previous guesses were: #{@guesses.join(',')}"
  end

  def get_guess
    puts "Enter your next letter:"
    guess = gets.chomp.downcase
    until guess.length == 1 && (guess.ord > 96 && guess.ord < 123) && !(@guesses.include?(guess))
      if @guesses.include?(guess)
        puts "You've already entered that guess."
      end
      puts "Please enter a valid single letter a through z:"
      guess = gets.chomp.downcase
    end
    puts guess
  end
end

game = Hangman.new
game.play_game
