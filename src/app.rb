require 'sinatra'

class MainApp < Sinatra::Base
  use Rack::Session::Pool, expire_after: 2_592_000

  get '/start_session' do
    session[:data] = params[:data]
    session[:data_length] = params[:data].length
    "Session ID: #{session.id}\nData: #{session[:data]}\nLength: #{session[:data_length]}\n"
  end

  get '/destroy_session' do
    destroied_session_id = session.id
    session.destroy
    "Destroied session ID: #{destroied_session_id}\n"
  end

  get '/check_session' do
    if session[:data] then
      "Session ID: #{session.id}\nData: #{session[:data]}\nLength: #{session[:data_length]}\n"
    else
      "The session is empty.\n"
    end
  end

end
