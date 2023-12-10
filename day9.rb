require 'awesome_print'

class Day9
  def initialize
    file = File.open("inputs/day9.txt")
    @report = file.readlines(chomp: true).map { |line| line.split(' ').map(&:to_i) }
  end

  def part_1
    next_numbers = []
    @report.each do |line|
      next_numbers << extrapolate_next_number(line)
    end
    next_numbers.sum
  end

  private

  def extrapolate_next_number(line)
    steps = [line]
    while steps.last.uniq.count != 1
      steps << get_line_differences(steps.last)
    end
    steps.reverse.each_with_index do |step, index|
      next if index == 0
      step << step.last + steps.reverse[index - 1].last
    end
    steps.first.last
  end

  def get_line_differences(line)
    differences = []
    line.each_with_index do |number, index|
      next if index == 0
      differences << line[index] - line[index - 1]
    end
    differences
  end
end

day_9 = Day9.new
ap day_9.part_1