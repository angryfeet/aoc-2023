require 'awesome_print'

class Day6
  def initialize
    file = File.open('inputs/day6.txt')
    lines = file.readlines(chomp: true)
    @race_times = lines[0].split(':')[1].split.map(&:strip).map(&:to_i)
    @race_distances = lines[1].split(':')[1].split.map(&:strip).map(&:to_i)
  end

  def part_1
    winning_strats = []

    @race_times.each_with_index do |time, ind|
      winning_strats << beats_the_record(time, @race_distances[ind])
    end
    winning_strats.inject(&:*)
  end

  def part_2
    race_time = @race_times.map(&:to_s).join.to_i
    race_distance = @race_distances.map(&:to_s).join.to_i
    beats_the_record(race_time, race_distance)
  end

  def beats_the_record(race_time, record)
    ways_to_win_this_race = 0

    for hold_time in 0..race_time do
      this_distance = (race_time - hold_time) * hold_time
      ways_to_win_this_race += 1 if this_distance > record
    end
    ways_to_win_this_race
  end
end

day_6 = Day6.new
ap day_6.part_1
ap day_6.part_2