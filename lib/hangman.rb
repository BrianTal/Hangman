require 'yaml'

class WordSelector
  attr_reader :word
  def initialize
    @word = generate_word
  end

  def generate_word
    dictionary = IO.readlines("./dictionary.txt")
    word = dictionary[rand(0..dictionary.length)].chop
    until word.length >= 5 && word.length <= 12 do
      word = dictionary[rand(0..dictionary.length)].chop
    end
    return word
  end
end

class Hangman
  attr_accessor :word, :word_array, :guesses_remaining, :solution_display, :guesses
  def initialize()
    @word = WordSelector.new.word
    @word_array = @word.split('')
    @guesses_remaining = 7
    @solution_display = []
    create_solution_display
    @guesses = []
    @game_over = false
  end

  def create_solution_display
    ch_array = @word.split('')
    ch_array.each { @solution_display.push("_") }
  end

  def play_game
    puts "Enter 2 to load game or press enter for new game."
    load_or_not = gets.chomp
    if load_or_not == "2"
      load_game
    end
    until @game_over || @guesses_remaining < 1 do
      display_game_info
      current_guess = get_guess
      if current_guess == "save"
        save
        exit 
      end
      check_guess(current_guess)
      @game_over = self.win?
    end
    if self.win?
      puts "Congratulations you solved the word: #{@word.capitalize}!!"
    else
      puts "Sorry you ran out of guesses! Game Over!"
    end
  end
  
  def display_game_info
    puts "============================="
    puts @word
    puts @solution_display.join(" ")
    puts "You have #{@guesses_remaining} guesses remaining"
    guess_string = @guesses.join(",")
    puts "Your previous guesses were: #{@guesses.join(',')}"
  end

  def get_guess
    print "Enter your next letter or 'save' to save game: "
    guess = gets.chomp.downcase
    return guess if guess == "save"
    until guess.length == 1 && (guess.ord > 96 && guess.ord < 123) && !(@guesses.include?(guess))
      if @guesses.include?(guess)
        puts "You've already entered that guess!"
      end
      print "Please enter a valid single letter a through z that was not guessed before: "
      guess = gets.chomp.downcase
    end
    @guesses.push(guess)
    return guess
  end

  def check_guess(guess)
    if @word_array.include?(guess)
      puts "Good Choice!"
      @word_array.each_with_index do | ch, index |
        if ch == guess
          @solution_display[index] = ch
        end
      end
    else
      puts "Sorry the word does not contain that letter!"
      @guesses_remaining -= 1
    end
  end

  def win?
    @word_array == @solution_display
  end

  def save
    Dir.mkdir('./game_data') unless Dir.exist?('./game_data')
    print "Enter file name: "
    filename = gets.chomp
    File.open("./game_data/#{filename}.yml", 'w') { |f| YAML.dump([] << self, f) }
    puts "Thank you for playing"
  end

  def load_game
    game_name = get_game_name
    yaml = YAML.load_file("./game_data/#{game_name}.yml", permitted_classes: [Hangman])
    @word = yaml[0].word
    @word_array = yaml[0].word_array
    @guesses_remaining = yaml[0].guesses_remaining
    @solution_display = yaml[0].solution_display
    @guesses = yaml[0].guesses
  end

  def get_game_name
    display_saved_games
    print "What game would you like to load: "
    game = gets.chomp
  end

  def display_saved_games
    puts "You have the following saves:"
    saved_games = Dir.glob('./game_data/*')
    saved_games.each do |game|
      print "#{game.split('/')[2]} "
    end
    puts ""
  end

end

game = Hangman.new
game.play_game
p game
