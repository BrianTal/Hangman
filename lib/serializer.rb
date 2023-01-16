module Serializer
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