require 'awesome_print'

class Day11
  def initialize
    file = File.open("inputs/day11.txt")
    @input = file.readlines(chomp: true).map { |line| line.split('')}
    @empty_cols = blank_cols.freeze
    @empty_rows = blank_rows.freeze
    @coords = get_coords.freeze
  end

  def part_1
   @coords.combination(2).to_a.map do |start, finish|
      get_distance(start, finish, 1)
    end.sum
  end

  def part_2
    @coords.combination(2).to_a.map do |start, finish|
      get_distance(start, finish, 2)
    end.sum
  end

  private

  def blank_cols
    cols = []
    @input.transpose.each_with_index do |line, y|
      if line.all? { |char| char == '.' }
        cols << y+1
      end
    end
    cols
  end

  def blank_rows
    rows = []
    @input.each_with_index do |line, y|
      if line.all? { |char| char == '.' }
        rows << y+1
      end
    end
    rows
  end

  def get_coords
    c = []
    @input.each_with_index do |line, y|
      line.each_with_index do |char, x|
        c << [x+1, y+1] if char == '#'
      end
    end
    c
  end

  def get_distance(start, finish, part)
    expanded_number   = part == 1 ? 1 : 999999
    cols_passed = (start.first..finish.first).to_a 
    rows_passed = (start.last..finish.last).to_a
    cols_passed = (finish.first..start.first).to_a if cols_passed.empty?
    rows_passed = (finish.last..start.last).to_a if rows_passed.empty?
    empty_cols_passed = (cols_passed & @empty_cols).length
    empty_rows_passed = (rows_passed & @empty_rows).length
    x_distance = (start.first - finish.first).abs
    y_distance = (start.last - finish.last).abs
    #ap "start: #{start}, finish: #{finish}, x_distance: #{x_distance}, y_distance: #{y_distance}, empty_cols_passed: #{empty_cols_passed}, empty_rows_passed: #{empty_rows_passed}, total_distance: #{x_distance + y_distance + empty_cols_passed*expanded_number + empty_rows_passed*expanded_number}"
    total_distance = x_distance + y_distance + empty_cols_passed*expanded_number + empty_rows_passed*expanded_number
    
    total_distance
  end

end

day_11 = Day11.new
ap day_11.part_1
ap day_11.part_2