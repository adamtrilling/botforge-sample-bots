require 'rubygems'

require 'bundler'
Bundler.setup

require 'sinatra'
require 'json'

class SampleBots < Sinatra::Application

  set :logging, true

  post '/:game/:bot' do
    begin
      game_state = JSON.parse(request.body.read)
    rescue JSON::ParserError
      status 400
      return "Unparseable request"
    end
    
    case game_state["request_type"]
    # accept proposed match requests unless one of the decliners is used
    when 'proposed'
      if (params[:bot] == 'code_decliner')
        status 404
        return ''
      elsif (params[:bot] == 'response_decliner')
        status 200
        return MultiJson.encode({"decline" => 1})
      else
        status 200
        return ''
      end
    # discard completed game requests - none of these bots use them
    when 'completed'
      status 200
      return ''
    # otherwise, branch off to the game and return the move
    else

      case params[:game]
      when "chess"
        require './chess'
        player = Chess.new(game_state)
      
        unless (['random'].include?(params[:bot]))
          status 404
          return "Bot not found"
        end
      else
        status 404
        return "Game not found"
      end

      response = player.send(params[:bot])
    
      response.to_json
    end
  end
end
