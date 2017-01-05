require 'sinatra'

class MainApp < Sinatra::Base
  configure do
    # セッション管理を有効にする
    enable :sessions
  end

  get '/start_session' do
    session[:started] = true
    "Session ID: #{session.id}"
  end

  get '/destroy_session' do
    destroied_session_id = session.id
    session.destroy
    "Destroied session ID: #{destroied_session_id}\n"
  end

  get '/check_session' do
    if session[:started] then
      "Session ID: #{session.id}"
    else
      "The session is empty.\n"
    end
  end

end
