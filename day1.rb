require 'awesome_print'

class Day1

    def initialize
        file = File.open("inputs/day1.txt")
        @input = file.readlines
    end

    def part_1
        pattern = /[0-9]/
        @input.map { |line|
            matches = line.scan(pattern)
            [matches.first, matches.last].join().to_i
        }.inject(&:+)
    end

    def part_2
        pattern = /(?=([0-9]|one|two|three|four|five|six|seven|eight|nine|zero))/

        @input.map { |line|
            matches = line.scan(pattern).flatten
            [to_number(matches.first), to_number(matches.last)].join().to_i
        }.sum
    end

    def to_number(str)
        case str
        when 'one'
            '1'
        when 'two'
            '2'
        when 'three'
            '3'
        when 'four'
            '4'
        when 'five'
            '5'
        when 'six'
            '6'
        when 'seven'
            '7'
        when 'eight'
            '8'
        when 'nine'
            '9'
        when 'zero'
            '0'
        else
            str
        end
    end
end

day_1 = Day1.new
ap day_1.part_1
ap day_1.part_2
