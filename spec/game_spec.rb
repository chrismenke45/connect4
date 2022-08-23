require "./lib/game.rb"

describe Game do
  subject(:game) { described_class.new() }
  let(:empty_game_board) { [[1, 2, 3, 4, 5, 6, 7], ["_", "_", "_", "_", "_", "_", "_"], ["_", "_", "_", "_", "_", "_", "_"], ["_", "_", "_", "_", "_", "_", "_"], ["_", "_", "_", "_", "_", "_", "_"], ["_", "_", "_", "_", "_", "_", "_"], ["_", "_", "_", "_", "_", "_", "_"]] }
  it "game.new works" do
    expect(game.board).to eql(empty_game_board)
  end
  context "Must remove 'private' from class for these to not fail" do
    context "Game adds game piece in proper spot" do
      it "adds game piece at bottom of correct column" do
        game.add_piece("1".to_i - 1, "X")
        empty_game_board[6][0] = "X"
        expect(game.board).to eql(empty_game_board)
      end
      it "adds game piece at higher row when pieces are already in the column" do
        game.add_piece("1".to_i - 1, "X")
        game.add_piece("1".to_i - 1, "X")
        empty_game_board[6][0] = "X"
        empty_game_board[5][0] = "X"
        expect(game.board).to eql(empty_game_board)
      end
    end
    context "Game detects 4 in a row" do
      context "Horizontal 4 in a rows" do
        it "detects 4 in a row horizontally right" do
          i = 1
          while i < 5
            game.add_piece(i, "O")
            i += 1
          end
          expect(game.check_horizontal_win(2, "O")).to be_truthy
        end
        it "detects 4 in a row horizontally left" do
          i = 6
          while i > 2
            game.add_piece(i, "O")
            i -= 1
          end
          expect(game.check_horizontal_win(4, "O")).to be_truthy
        end
      end
      it "detects 4 in a row vertically" do
        i = 1
        while i < 5
          game.add_piece(0, "X")
          i += 1
        end
        game.show_board
        expect(game.check_vertical_win(0, "X")).to be_truthy
      end
      it "detects 4 in a row diagonally (+ slope)" do
        i = 3
        while i < 7
          (i - 3).times { game.add_piece(i, "O") } if i > 3
          game.add_piece(i, "X")
          i += 1
        end

        expect(game.check_pos_diagonal_win(6, "X")).to be_truthy
      end
      it "detects 4 in a row diagonally (- slope)" do
        i = 3
        while i < 7
          (6 - i).times { game.add_piece(i, "O") } if i < 6
          game.add_piece(i, "X")
          i += 1
        end
        expect(game.check_neg_diagonal_win(4, "X")).to be_truthy
      end
    end
    context "doesnt detect incorrect 4 in a rows" do
      it "doesnt detect incorrect horizontals" do
        game.add_piece(1, "O")
        game.add_piece(2, "O")
        game.add_piece(3, "X")
        expect(game.check_horizontal_win(2, "O")).to be_falsy
      end
      it "doesnt detect incorrect verticals" do
        game.add_piece(1, "O")
        game.add_piece(1, "O")
        game.add_piece(1, "O")
        game.add_piece(3, "X")
        expect(game.check_vertical_win(1, "O")).to be_falsy
      end
      it "doesnt detect incorrect pos diagonals" do
        game.add_piece(1, "O")
        game.add_piece(2, "X")
        game.add_piece(2, "O")
        game.add_piece(3, "X")
        game.add_piece(3, "X")
        game.add_piece(3, "O")

        expect(game.check_pos_diagonal_win(2, "O")).to be_falsy
      end
      it "doesnt detect incorrect neg diagonals" do
        game.add_piece(5, "O")
        game.add_piece(4, "X")
        game.add_piece(4, "O")
        game.add_piece(3, "X")
        game.add_piece(3, "X")
        game.add_piece(3, "O")
        expect(game.check_neg_diagonal_win(5, "O")).to be_falsy
      end
    end
    context "checks for valid input from user" do
      it "valid input of number is valid" do
        expect(game.valid_input?("5".to_i)).to be_truthy
      end
      it "invalid input of letter is invalid" do
        expect(game.valid_input?("h".to_i)).to be_falsy
      end
      it "invalid input to big of of number invalid" do
        expect(game.valid_input?("15".to_i)).to be_falsy
      end
      it "invalid input to small of of number invalid" do
        expect(game.valid_input?("0".to_i)).to be_falsy
      end
    end
  end
end
