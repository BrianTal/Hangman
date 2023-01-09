def get_word
  dictionary = IO.readlines("./dictionary.txt")
  not_correct_length = true
  while not_correct_length do
    word = dictionary[rand(0..dictionary.length)].chop
    puts word.length
    if word.length >= 5 && word.length <= 12
      not_correct_length = false
    end
  end
  return word
end