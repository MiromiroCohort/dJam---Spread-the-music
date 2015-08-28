out_string = ""
"HELLO WORLD HOW ARE YOU".gsub(/\w+/) do |word|
  out_string << word.capitalize + " "
end

p out_string
