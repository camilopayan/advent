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
      memo + ((played == num) ? 1 : 0)
    end
  end
end

def get_winnings(count)
  return 0 if count.zero?

  2**(count - 1)
end

sum = 0
matches = {}
for line in File.open("04.txt")
  card_number, winning_numbers, played_numbers = parse_line line
  sum += get_winnings get_match_count(winning_numbers, played_numbers)
  matches[card_number.to_i] = get_match_count(winning_numbers, played_numbers)
end
p "Part 1 Sum: #{sum}"

instances = {}
copies = {}
matches.keys.each do |card|
  instances[card] = 1
  copies[card] = []
end

matches.each do |card, num|
  # p "Card #{card} gets num #{num}"
  next if num == 0
  ((card+1)..(card+num)).each do |cc|
    copies[card] << cc
  end
  # puts "Original copies from winning numbers"
  # pp copies
  next if card == 1

  (card-1).downto(1).each do |previous_card|
    copies[previous_card].each do |already_copied|
      # puts "Looking at #{previous_card} with already copied #{already_copied}"
      if already_copied == card
        # puts "Add this card's copies"
        copies[card].each { |copied_card| copies[previous_card] << copied_card }
      end
    end
  end
  # pp copies
end

copies.each do |card, copied_cards|
  copied_cards.each { |cc| instances[cc] += 1 }
#  puts "Card #{card} has copies #{copied_cards}"
#  pp instances
end
p2_sum = instances.values.reduce(0, :+)

p "Part 2 Sum: #{p2_sum}"
