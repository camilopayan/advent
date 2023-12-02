re = /\d/
sum = 0
File.open("./01.txt", "r") do |file_handle|
    file_handle.each_line do |str|
      first_digit = str.match(re)
      second_digit = str.reverse.match(re)
      number = "#{first_digit}#{second_digit}".to_i
      sum += number
    end
end

puts sum

numbers = {
  '1' => 1,
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9,
  'one' => 1,
  'two' => 2,
  'three' => 3,
  'four' => 4,
  'five' => 5,
  'six' => 6,
  'seven' => 7,
  'eight' => 8,
  'nine' => 9
}

re = /(#{numbers.keys.join('|')})/
rre = /(#{numbers.keys.map(&:reverse).join('|')})/
sum = 0
File.open("./01.txt", "r") do |file_handle|
  file_handle.each_line do |str|
    first_digit = numbers[str.match(re).to_s]
    second_digit = numbers[str.reverse.match(rre).to_s.reverse]
    number = "#{first_digit}#{second_digit}".to_i
    sum += number
  end
end

puts sum
