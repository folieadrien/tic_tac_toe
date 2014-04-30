require 'player'

class Computer < Player
  attr_accessor :symbol

  def move(board)
    ennemy_symbol = find_ennemy_symbol
    location = find_next_location(board, ennemy_symbol)
    super(board, location)
  end

  def find_ennemy_symbol
    (@symbol == Parameters::X_SYMBOL) ? Parameters::O_SYMBOL : Parameters::X_SYMBOL
  end

  def find_next_location(board, ennemy_symbol)
    get_win(board, @symbol)               ||
    block_win(board, ennemy_symbol)       ||
    get_fork(board, @symbol)              ||
    block_fork(board, ennemy_symbol)      ||
    center(board)                         ||
    opposite_corner(board, ennemy_symbol) ||
    empty_square(board)
  end

  private

  def get_win(board, symbol)
    squares = get_wins_location(board, symbol)
    squares.first
  end

  alias :block_win :get_win

  def get_wins_location(board, symbol)
    wins = []
    board.empty_squares.each do |location|
      board.move(location, symbol)
      wins << location if board.win?(symbol)
      board.undo_move(location)
    end
    wins
  end

  def get_fork(board, symbol)
    get_fork_location(board, symbol)
  end

  alias :block_fork :get_fork

  def get_fork_location(board, symbol)
    board.empty_squares.each do |location|
      board.move(location, symbol)
      wins = get_wins_location(board, symbol)
      board.undo_move(location)
      return location if wins.size >= 2
    end
    nil
  end

  def center(board)
    Parameters::CENTER if board.move_available?(Parameters::CENTER)
  end

  def opposite_corner(board, ennemy_symbol)
    Parameters::OPPOSITE_CORNERS.each do |corner_1, corner_2|
      if board.square_has_symbol?(corner_1, ennemy_symbol) &&
         board.move_available?(corner_2)
        return corner_2
      end
    end
    nil
  end

  def empty_square(board)
    square = nil
    Parameters::CORNERS.each { |corner| square ||= corner if board.move_available?(corner) }
    Parameters::MIDDLES.each { |middle| square ||= middle if board.move_available?(middle) }
    square
  end

end
