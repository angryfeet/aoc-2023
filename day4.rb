require 'awesome_print'

class Day4
  def initialize
    file = File.open("inputs/day4.txt")
    @cards = file.readlines(chomp: true).map { |l| l.split(/\s\|\s|:\s/) }
  end

  def part_1
    winning_cards = []
    @cards.each do |_, winning_numbers, elfs_numbers|
      win_amount = nil
      matches = (winning_numbers.split & elfs_numbers.split).length
      matches.times do |x|
        win_amount = win_amount.nil? ? 1 : win_amount*2
      end
      winning_cards << win_amount
    end
    winning_cards.reject(&:nil?).sum
  end

  def part_2
    my_cards = Hash.new(0)
    @cards.each_with_index do |(card_id, winning_numbers, elfs_numbers), index|
      card_number = card_id.split.last.to_i
      my_cards[card_number] += 1
      matches = (winning_numbers.split & elfs_numbers.split).length
      copies = (index+2..index+1+matches).to_a
      copies.each do |copy_number|
        my_cards[copy_number] += my_cards[card_number]
      end
    end
    my_cards.values.sum
  end
end

day_4 = Day4.new
ap day_4.part_1
ap day_4.part_2