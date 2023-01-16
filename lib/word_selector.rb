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