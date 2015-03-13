require 'json'
require File.expand_path '../spec_helper.rb', __FILE__

describe "Chess bot" do

  describe 'random player' do
    before do
      post '/chess/random', params
    end

    context 'proposing a match' do
      let(:params) { {
        match_id: rand(10000),
        game: 'chess',
        request: 'proposal'
      }.to_json }

      it 'accepts the match' do
        expect(last_response.status).to eq 200
      end
    end

    context 'requesting a move' do
      let(:params) { {
        match_id: rand(10000),
        game: 'chess',
        request: 'move',
        participants: {
          '0': {
            id: rand(10000),
            rating: 2000.0,
            you: 'true'
          },
          '1': {
            id: rand(10000),
            rating: 1980.0
          }
        },
        state: {
          "board"=>"rnbqkbnrpppppppp................................PPPPPPPPRNBQKBNR",
          "history"=>[],
         "legal_moves"=>
          ["a2-a3",
           "a2-a4",
           "b2-b3",
           "b2-b4",
           "c2-c3",
           "c2-c4",
           "d2-d3",
           "d2-d4",
           "e2-e3",
           "e2-e4",
           "f2-f3",
           "f2-f4",
           "g2-g3",
           "g2-g4",
           "h2-h3",
           "h2-h4",
           "b2-a3",
           "b2-c3",
           "g2-f3",
           "g2-h3"],
         "next_to_move"=>0
       }
      }.to_json }

      it 'accepts the match' do
        expect(last_response.status).to eq 200
      end

      it 'returns a move' do
        expect(JSON.parse(last_response.body)).to have_key('move')
      end
    end
  end
end