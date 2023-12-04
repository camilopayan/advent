# Open file and loop over it
def parse_line(line)
  re = /Card\s+(\d+): ([\d\s]+) \|(.*)/
  _, card_number, winning_numbers, played_numbers = re.match(line).to_a
  [
    card_number,
    winning_numbers&.split,
    played_numbers&.split
  ]
end

def get_match_count(winning_numbers, played_numbers)
  winning_numbers.reduce(0) do |count, num|
    count + played_numbers.reduce(0) do |memo, played|
      p "Count #{count} Num #{num} Memo #{memo} Played #{played}"
      memo + ((played == num) ? 1 : 0)
    end
  end
end

def get_winnings(count)
  return 0 if count.zero?

  2**(count - 1)
end

sum = 0
for line in File.open("04.txt")
  card_number, winning_numbers, played_numbers = parse_line line
  sum += get_winnings get_match_count(winning_numbers, played_numbers)
  puts line
  p card_number
end
p sum
