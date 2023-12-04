sum = 0

def line_sum(line)
  numbers = []
  line.to_enum(:scan, /[^.\d\s](\d+)/).map { Regexp.last_match }.each do |match|
    num = match[1]
    numbers << num.to_s.to_i
    # line.sub!(/#{num}/, '.' * num.to_s.length)
  end
  line.to_enum(:scan, /(\d+)[^.\d\s]/).map { Regexp.last_match }.each do |match|
    num = match[1]
    numbers << num.to_s.to_i
    # line.sub!(/#{num}/, '.' * num.to_s.length)
  end
  pp numbers
  sum = numbers.reduce(0, :+)
  p "Add on #{sum}"
  sum
end

def symbol_positions(line)
  matches = line.to_enum(:scan, /([^.\d\s])/).map { Regexp.last_match }
  matches.map { |m| m.begin(1) }
end

def adjacents_sum(line, positions)
  matches = line.to_enum(:scan, /(\d+)/).map { Regexp.last_match }
  numbers = matches.filter do |match|
    positions.reduce(false) do |memo, pos|
      a, o = match.offset(0)
      pos.between?(a-1, o+1) || memo
    end
  end
  numbers.each do |number|
    # line.sub!(/#{number[0]}/, '.' * number[0].to_s.length)
  end
  pp numbers
  sum = numbers.map { |m| m[0].to_i }.reduce(0, :+)
  p "Add on #{sum}"
  sum
end
#
def process_three_lines(previous_line, current_line, next_line)
  sum = 0
  # Sum up all part numbers on current line
  sum += line_sum(current_line)
  # get the positions of all symbols on current line
  positions = symbol_positions(current_line)
  # Use positions to get part numbers on adjacent lines
  sum += adjacents_sum(previous_line, positions)
  sum += adjacents_sum(next_line, positions) unless next_line.nil?
  sum
end

# open file
f = File.open("03.txt")
count = 1
previous_line = f.readline
current_line = f.readline
p "Line #{count}"

# Sum up all the part numbers on the first line
sum += line_sum(previous_line)

next_line = nil

f.each do |next_line|
  count += 1
  p "Line #{count}"

  sum += process_three_lines(previous_line, current_line, next_line)

  p "Current sum #{sum}"
  # Prepare for a new line
  previous_line = current_line
  current_line = next_line
end

count += 1
p "Line #{count}"

sum += process_three_lines(previous_line, current_line, next_line)

puts sum
