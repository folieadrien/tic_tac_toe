require 'game'
require 'board'
require 'player'
require 'computer'
require 'console_display'

class Application

  def initialize
    @game = Game.new
  end

  def launch
    while(42)
      if @game.started?
        move = ConsoleDisplay.ask_for_move
        status = @game.play(move)
        ConsoleDisplay.display_game(@game.board, status)
      else
        answer = ConsoleDisplay.ask_new_game
        if answer == 'y'
          status = @game.start
          ConsoleDisplay.display_start(@game.board, status)
        end
      end
    end
  end

end