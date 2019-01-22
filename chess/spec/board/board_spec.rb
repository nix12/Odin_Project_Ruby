require "board/board"

RSpec.describe Board do
  describe "new gameboard" do
    let(:gameboard) { Board.new }

    it "should be an instance of 'Board'" do
      expect(gameboard).to be_an_instance_of(Board)
    end

    it "should respond to board and display" do
      expect(gameboard).to respond_to(:board)
      expect(gameboard).to respond_to(:display)
    end

    it "should build the gameboard with 64 spaces" do
      gameboard.build_board
      expect(gameboard.board.length).to eq(64)
    end

    it "should build the display with 64 spaces" do
      gameboard.build_display
      expect(gameboard.display.flatten.length).to eq(64)
    end

    describe "#find" do 
      let(:gameboard) { Board.new }

      before do
        gameboard.build_board
      end

      it "should find node location [5, 5]" do 
        expect(gameboard.find([5, 5]).location).to eq([5, 5])
      end

      it "should return nil if node does not exist" do
        expect(gameboard.find([-1, 9])).to eq(nil)
      end
    end

    describe "#print_board" do
      let(:gameboard) { Board.new }

      it "should print board" do
        gameboard.build_board
        expect { gameboard.print_board }.to output.to_stdout
      end
    end

    describe "#print_display" do
      let(:gameboard) { Board.new }

      it "should print display" do
        gameboard.build_display
        expect { gameboard.print_display }.to output.to_stdout
      end
    end
  end
end
