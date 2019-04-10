require 'gameplay/save_mechanics'
require 'board/board'
require 'player/player'

CONN = PG.connect(
    dbname: ENV['DB_TEST'],
    user: ENV['USERNAME'],
    password: ENV['DB_PASSWORD'],
    host: 'localhost',
    port: 5433
  )

RSpec.configure do |config|
  config.before(:each) do
    CONN.exec(
      'CREATE TABLE IF NOT EXISTS chess_test(
        Id SERIAL PRIMARY KEY,
        Board TEXT,
        Player1 TEXT,
        Player2 TEXT,
        Created_at TIMESTAMP,
        Updated_at TIMESTAMP
      )'
    )
  end

  config.after(:each) do
    CONN.exec('DROP TABLE chess_test')
  end
end

RSpec.describe SaveMechanics do
  let(:board) { Board.new }
  let(:player1) { Player.new('Test', 'White', true) }
  let(:player2) { Player.new('User', 'black', false) }

  before(:each) do
    board.build_board
  end

  describe '#self.preserve_turn' do
    it 'should flip both players active status before save' do
      expect(player1.active).to eq(true)
      expect(player2.active).to eq(false)
      subject.preserve_turn(player1, player2)
      expect(player1.active).to eq(false)
      expect(player2.active).to eq(true)
    end
  end

  describe '#self.from_json!' do
    let(:saved_board) { board.to_json }

    it 'should convert JSON string to hash' do
      expect(saved_board).to be_kind_of(String)

      converted_board = subject.from_json!(saved_board)
      converted_board['@board'].each do |square|
        expect(square).to be_kind_of(Hash)
      end
    end
  end

  describe '#self.recursive_formatting' do
    let(:saved_board) { board.to_json }
    let(:converted_board) { subject.from_json!(saved_board) }

    it 'should convert the JSON keys from strings to symbols' do
      
      converted_board['@board'].each do |key|
        expect(key).to be_kind_of(Hash)
      end
      
      formated_board = subject.recursive_formatting(converted_board)
      formated_board.keys.each do |key|
        expect(key).to be_kind_of(Symbol)
      end
    end
  end

  describe '#self.save' do
    it 'should save one record to the database' do
      allow(subject).to receive(:number_of_saved_games) { 0 }

      subject.save(
        board.to_json,
        player1.to_json,
        player2.to_json,
        DateTime.now.strftime("%b %-d %Y %-l:%M %p"),
        DateTime.now.strftime("%b %-d %Y %-l:%M %p")
      )

      res = CONN.exec(
        'SELECT COUNT(*)
        FROM chess_test'
      )
      
      expect(CONN.exec('SELECT COUNT(*) FROM chess_test')).to eq(res[0]['count'].to_i)
    end
  end
end
