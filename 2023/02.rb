sum_one = 0
sum_two = 0
red_max = 12
green_max = 13
blue_max = 14
File.open("./02.txt", "r") do |file_handle|
  file_handle.each_line do |str|
    game, pulls = str.split(':')
    game_number = game.match(/\d+/).to_s.to_i
    valid_game = true
    minimums = {
      :red => 0,
      :green => 0,
      :blue => 0
    }
    pulls.split(';').each do |p|
      p.split(',').each do |color_stat|
        number, color = color_stat.split
        n = number.to_i
        case color
        in 'red'
          valid_game &= false if n > red_max
          minimums[:red] = n if n > minimums[:red]
        in 'green'
          valid_game &= false if n > green_max
          minimums[:green] = n if n > minimums[:green]
        in 'blue'
          valid_game &= false if n > blue_max
          minimums[:blue] = n if n > minimums[:blue]
        end
      end
    end
    sum_one += game_number if valid_game
    power = minimums.values.reduce(&:*)
    sum_two += power
  end
end

puts sum_one
puts sum_two
