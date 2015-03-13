class Chess
  def initialize(game_state)
    @game_state = game_state
  end

  def random
    case @game_state['request']
    when 'proposal'
      ''
    when 'move'
      { move: @game_state['state']['legal_moves'].sample }
    end
  end
end