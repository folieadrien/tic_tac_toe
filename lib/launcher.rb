class Launcher
  attr_reader :game, :board, :player_one, :player_two

  def initialize
    @board      = Board.new
    @player_one = Human.new(Parameters::X_SYMBOL, InputHelper)
    @player_two = Computer.new(Parameters::O_SYMBOL)
    @game       = Game.new(@board, @player_one, @player_two)
  end

  def launch
    answer = InputHelper.ask_for_new_game
    play_game if answer == 'y'
  end

  def play_game
    game.start
    OutputHelper.print_board(@board)
    while(game.started?)
      game.play
      OutputHelper.print_board(@board)
      OutputHelper.print_state(game.state)
    end
  end

end
