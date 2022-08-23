require "./lib/player.rb"

class Game
  attr_reader :board

  BOARD_ROWS = 6
  BOARD_COLUMNS = 7

  def initialize
    @board = (Array.new(BOARD_ROWS) { Array.new(BOARD_COLUMNS) { "_" } }).unshift((1..BOARD_COLUMNS).to_a)
  end

  def play_game
    game_setup
    players = [@player1, @player2]
    i = 2
    column = 1
    current_player = players[0]
    until check_win(column, current_player.mark)
      current_player = players[i % 2]
      column = current_player.computer ? computer_move : player_move(current_player)
      add_piece(column, current_player.mark)
      show_board
      i += 1
    end
    puts "#{current_player.name} won!"
  end

  def computer_move
    chosen_column = -1
    until valid_input?(chosen_column)
      chosen_column = rand(1..BOARD_COLUMNS)
    end
    chosen_column - 1
  end

  def player_move(player)
    chosen_column = -1
    until valid_input?(chosen_column)
      puts "#{player.name}: Which column number would you like to drop your piece?"
      chosen_column = gets.chomp.to_i
      puts "Please enter a single number between 1 and #{BOARD_COLUMNS}" unless valid_input?(chosen_column)
    end
    chosen_column - 1
  end

  def game_setup
    type = 0
    until type == 1 || type == 2
      puts "1v1 or 1vComputer? Enter 1 for 1v1, Enter 2 for 1vComputer"
      type = gets.chomp.to_i
      puts "Invalid input, please enter 1 or 2" unless type == 1 || type == 2
    end
    type == 1 ? two_player_names : one_player_name
  end

  def two_player_names
    puts "Enter player 1 name:"
    @player1 = Player.new(gets.chomp, "X")
    puts "Enter player 2 name:"
    @player2 = Player.new(gets.chomp, "O")
  end

  def one_player_name
    puts "Enter player name:"
    @player1 = Player.new(gets.chomp, "X")
    @player2 = Player.new("Computer", "O", true)
  end

  #private

  def show_board
    for row in @board
      line = ""
      row.each_with_index do |column, index|
        index == row.length - 1 ? line << column.to_s : line << "#{column}|"
      end
      puts line
    end
  end

  def add_piece(column, mark)
    i = BOARD_ROWS
    until @board[i][column] == "_" || i < 1
      i -= 1
    end
    @board[i][column] = mark
  end

  def valid_input?(input)
    return false unless input >= 1 && input <= BOARD_COLUMNS
    @board[1][input - 1] == "_"
  end

  def check_win(column, mark)
    check_horizontal_win(column, mark) || check_vertical_win(column, mark) || check_pos_diagonal_win(column, mark) || check_neg_diagonal_win(column, mark)
  end

  def check_horizontal_win(column, mark)
    row = find_mark_row(column, mark)
    left_count = column
    while @board[row][left_count - 1] == mark && left_count > 0
      left_count -= 1
    end
    right_count = column
    while @board[row][right_count + 1] == mark && left_count < BOARD_COLUMNS - 1
      right_count += 1
    end
    right_count - left_count >= 3
  end

  def check_vertical_win(column, mark)
    row = find_mark_row(column, mark)
    down_count = row
    while @board.dig(down_count + 1, column) == mark && down_count < BOARD_ROWS
      down_count += 1
    end
    down_count >= row + 3
  end

  def check_pos_diagonal_win(column, mark)
    row = find_mark_row(column, mark)
    down_y = row
    left_x = column
    while down_y < BOARD_ROWS && left_x > 0 && @board[down_y + 1][left_x - 1] == mark
      down_y += 1
      left_x -= 1
    end
    up_y = row
    right_x = column
    while up_y > 1 && right_x < BOARD_COLUMNS - 1 && @board[up_y - 1][right_x + 1] == mark
      up_y -= 1
      right_x += 1
    end
    right_x - left_x >= 3
  end

  def check_neg_diagonal_win(column, mark)
    row = find_mark_row(column, mark)
    down_y = row
    right_x = column
    while down_y < BOARD_ROWS && right_x < BOARD_COLUMNS - 1 && @board[down_y + 1][right_x + 1] == mark
      down_y += 1
      right_x += 1
    end
    up_y = row
    left_x = column
    while up_y > 1 && left_x > 0 && @board[up_y - 1][left_x - 1] == mark
      up_y -= 1
      left_x -= 1
    end
    right_x - left_x >= 3
  end

  def find_mark_row(column, mark)
    row = 1
    until @board[row][column] == mark || row > BOARD_ROWS - 1
      row += 1
    end
    row
  end
end
