require 'awesome_print'

class Day12
  def initialize
    file = File.open("inputs/day12.txt")
    @lines = file.readlines(chomp: true)
  end

  def part_1
    all_matches = 0

    @lines.each do |line|
      record, damaged_groups = line.split(' ')
      damaged_groups = damaged_groups.split(',').map(&:to_i)
      if (damaged_groups.sum + damaged_groups.count - 1) < record.length
        unknown = record.count('?')
        matches = 0
        ['.', '#'].repeated_permutation(unknown).to_a.each do |perm|
          enum = perm.to_enum
          possible = record.gsub('?') { enum.next }
          matches += 1 if possible.split('.').reject(&:empty?).map { |x| x.length } == damaged_groups
        end
        all_matches += matches
      else
        all_matches += 1
      end
    end
    all_matches
  end
end

day_12 = Day12.new
ap day_12.part_1