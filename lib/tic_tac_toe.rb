#!/usr/bin/ruby

require_relative 'game'
require_relative 'board'
require_relative 'player'
require_relative 'human'
require_relative 'computer'

def display_board(board)
  #puts "#{board[0]} #{board[1]} #{board[2]}"
  #puts "#{board[3]} #{board[4]} #{board[5]}"
  #puts "#{board[6]} #{board[7]} #{board[8]}"
  puts board.to_s
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  inst = 'Please enter your move'

  puts inst
  puts game.start
  display_board(game.get_display)
  ARGF.each do |line|

    puts game.play(line.to_i)
    display_board(game.get_display)
    puts inst
  end
end