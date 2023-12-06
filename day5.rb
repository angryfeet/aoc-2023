#@maps = [
#  {
#    source: ,
#    destination: ,
#    map: [
#      {
#        destination_start:
#        source_start:
#        range:
#      }
#    ]
#  }
#]

require 'awesome_print'

class Day5
  def initialize
    process_input
  end

  def part_1
    process_seeds(@seeds_pt1)
  end

  def part_2
    process_seeds(@seeds_pt2)
  end

  def process_seeds(seeds)
    locations = []
    seeds.each do |seed|
      locations << process_map(source: 'seed', number: seed)
    end
    locations.min
  end

  private

  def process_map(source:, number:)
    destination_number = nil
    map_to_process = @maps.select { |m| m[:source] == source }.first
    return number if map_to_process.nil?
    map_to_process[:map].each do |map|
      next if number < map[:source_start] || number > map[:source_start] + map[:range]
      destination_number = map[:destination_start] + number - map[:source_start]
    end
    
    process_map(source: map_to_process[:destination], number: destination_number || number)
  end

  def process_input
    file = File.open("inputs/day5.txt")
    input = file.read.split("\n\n")
    
    # Seeds
    @seeds_pt1= input.shift.split(': ').last.split.map(&:to_i)

    seed_arr = []
    @seeds_pt1.each_slice(2) do |start_no, range|
      seed_arr << (start_no..start_no+range).to_a
    end
    @seeds_pt2 = seed_arr.flatten

    # Maps
    @maps = []
    input.each do |raw_map|
      map_hash = {}
      map_lines = raw_map.split("\n")
      
      # get source and destination
      title = map_lines.shift.split(/-|\s/)
      map_hash[:source] = title[0]
      map_hash[:destination] = title[2]

      # parse maps
      map_hash[:map] = []
      map_lines.each do |line|
        line_hash = {}
        line_hash[:destination_start], line_hash[:source_start], line_hash[:range] = line.split.map(&:to_i)
        map_hash[:map] << line_hash
      end
      @maps << map_hash
    end
  end
end

day_5 = Day5.new
ap day_5.part_1
ap day_5.part_2