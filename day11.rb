require 'awesome_print'

class Day11
  def initialize
    file = File.open("inputs/day11.txt")
    input = file.readlines(chomp: true).map { |line| line.split('')}
    @input = expand_input(input)
  end

  def part_1
    coords = []
    @input.each_with_index do |line, y|
      line.each_with_index do |char, x|
        coords << [x, y] if char == '#'
      end
    end

    coords.combination(2).to_a.map do |start, finish|
      (start.first - finish.first).abs + (start.last - finish.last).abs
    end.sum
  end

  def part_2

  end

  private

  def expand_input(input)
    empty_columns = Array.new(input.first.length, true)
    expanded_rows = []
    input.each_with_index do |line, index|
      expanded_rows << line
      expanded_rows << line unless line.include?('#')
    end
    expanded_cols = []
    expanded_rows.transpose.each_with_index do |line, index|
      expanded_cols << line
      expanded_cols << line unless line.include?('#')
    end
  expanded_cols.transpose
  end
end

day_11 = Day11.new
ap day_11.part_1