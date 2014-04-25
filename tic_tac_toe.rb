#!/usr/bin/ruby

require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/computer'

def display_square(board, location)
  board[location] || '.'
end

def display_board(board)
  puts " #{display_square(board, 0)} | #{display_square(board, 1)} | #{display_square(board, 2)}\n" +
       "-----------\n" +
       " #{display_square(board, 3)} | #{display_square(board, 4)} | #{display_square(board, 5)}\n" +
       "-----------\n" +
       " #{display_square(board, 6)} | #{display_square(board, 7)} | #{display_square(board, 8)}\n"
end

def display_start(game)
  status = game.start()

  system("clear")
  puts "-- New Game Started --\n"
  puts "-- Notif: #{status[:message]} --\n"
  display_board(game.board.to_a)
  puts INFOS
end

def display_status(status)
  case status[:code]
  when -1
    "-- Error: #{status[:message]} --\n"
  when 0
    "-- Notif: #{status[:message]} --\n"
  when 1
    "-- Warning: #{status[:message]} --\n"
  end
end

def display_game(game, move)
  status = game.play(move)

  system("clear")
  puts "----------------------\n"
  puts display_status(status)

  display_board(game.board.to_a)
  puts INFOS
end

if __FILE__ == $PROGRAM_NAME
  START = '-- Do you want to start a new game ? [y/n] --'
  INFOS = '-- Please enter your move (between 1 and 9) : --'
  game = Game.new

  system("clear")

  puts START

  ARGF.each do |line|
    if line.to_s == "y\n"
      puts 'lol'
      display_start(game)
    elsif game.started?
      move = line.to_i - 1
      display_game(game, move)
    elsif line.to_s == "exit\n"
      exit
    end
  end
end