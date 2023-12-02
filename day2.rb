require 'awesome_print'
class Day2
  def initialize
    file = File.open("inputs/day2.txt")
    input = file.readlines(chomp: true)
    @games = input.map { |line| line.split(': ').map { |v| v.include?(';') ? v.split('; ') : v } }.to_h
  end

  def part_1
    limits = {'red' => 12, 'green' => 13, 'blue' => 14}
    possible = []
    @games.each do |game_id, game_list|
      pass = true
      game_list.each do |game|
        colours = colour_counts(game)
        colours.each do |colour, count|
          pass = false if count.to_i > limits[colour]
        end
      end
      possible << game_id.split(' ')[1].to_i if pass
    end
    possible.sum
  end

  def part_2
    minimums = []
    @games.each do |_, game_list|
      game_mins = { 'red' => 0, 'green' => 0, 'blue' => 0 }
      game_list.each do |game|
        colours = colour_counts(game)
        colours.each do |colour, count|
          game_mins[colour] = count.to_i if game_mins[colour] < count.to_i
        end
      end
      minimums << game_mins.values
    end
    minimums.map { |mins| mins.inject(&:*) }.sum
  end

  def colour_counts(game)
    game.split(', ').map { |v| v.split(' ').reverse }.to_h
  end
end

day_2 = Day2.new
ap day_2.part_1
ap day_2.part_2
