def get_word
  dictionary = IO.readlines("./dictionary.txt")
  word = dictionary[rand(0..dictionary.length)].chop
  until word.length >= 5 && word.length <= 12 do
    word = dictionary[rand(0..dictionary.length)].chop
  end
  return word
end

