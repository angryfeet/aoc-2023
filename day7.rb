require 'awesome_print'

class Day7
  def initialize
    file = File.open('inputs/day7.txt')
    @input = file.readlines(chomp: true).map { |l| l.split(' ')}
  end

  def part_1
    sorted_by_hand_type = @input.sort_by { |hand, _| [
      get_hand_type(hand.split('')), 
      card_value(hand[0]),
      card_value(hand[1]),
      card_value(hand[2]),
      card_value(hand[3]),
      card_value(hand[4])
    ]}.reverse

    sorted_by_hand_type.each_with_index.inject(0) { |c, ((_, bid), i)|
      c + ((i+1) * bid.to_i)
    }
  end

  def part_2
    sorted_by_hand_type = @input.sort_by { |hand, _| [
      get_hand_type(hand.split(''), true), 
      card_value(hand[0], true),
      card_value(hand[1], true),
      card_value(hand[2], true),
      card_value(hand[3], true),
      card_value(hand[4], true)
    ]}.reverse

    sorted_by_hand_type.each_with_index.inject(0) { |c, ((_, bid), i)|
    c + ((i+1) * bid.to_i)
  }

  end

  private

  def get_hand_type(hand, joker = false)
    counts = hand.tally
    return 1 if (counts.values.include?(5) || (joker && counts.values.length == 2 && counts.keys.include?('J')) ) # Five of a kind
    return 2 if (counts.values.include?(4) || (joker && ((counts.values.sort == [1,1,3]  && counts['J'] == 1) || (counts.values.sort == [1,2,2] && counts['J'] == 2) || counts['J'] == 3 ))) # Four of a kind
    return 3 if (counts.values.sort == [2,3] || (joker && counts.values.sort == [1,2,2] && counts['J'] == 1)) # Full House
    return 4 if (counts.values.include?(3) || (joker && counts.keys.include?('J') && counts.values.sort == [1,1,1,2])) # Three of a kind
    return 5 if (counts.values.sort == [1,2,2] ) # Two pairs
    return 6 if (counts.values.sort == [1,1,1,2] || (joker && counts['J'] == 1)) # One pair
    return 7
  end

  def card_value(card, j_low = false)
    cards = j_low ? %w{A K Q T 9 8 7 6 5 4 3 2 1 J} : %w{A K Q J T 9 8 7 6 5 4 3 2 1}
    cards.index(card)
  end
end

day_7 = Day7.new
ap day_7.part_1
ap day_7.part_2