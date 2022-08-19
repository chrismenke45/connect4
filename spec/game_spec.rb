require "./game.rb"

describe Game do
  subject(:game) { described_class.new() }
  context "Game adds game piece in proper spot" do
    xit "adds game piece at bottom of correct column" do
    end
    xit "adds game piece at higher row when pieces are already in the column" do
    end
  end
  context "Game detects 4 in a row" do
    xit "detects 4 in a row horizontally" do
    end
    xit "detects 4 in a row vertically" do
    end
    xit "detects 4 in a row diagonally (+ slope)" do
    end
    xit "detects 4 in a row diagonally (- slope)" do
    end
  end
  context "checks for valid input from user" do
    xit "valid input of number is valid" do
      expect(game.valid_input?("5")).to be_falsy
    end
    xit "invalid input of letter is invalid" do
      expect(game.valid_input?("h")).to be_falsy
    end
    xit "invalid input to big of of number invalid" do
      expect(game.valid_input?("15")).to be_falsy
    end
    xit "invalid input to small of of number invalid" do
      expect(game.valid_input?("0")).to be_falsy
    end
  end
end
