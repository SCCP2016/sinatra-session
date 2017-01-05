require 'sinatra'

class MainApp < Sinatra::Base
  configure do
    # セッション管理を有効にする
    enable :sessions
  end

  get '/start_session' do
    session[:started] = true
    "A session has stared.\nYour session ID is \"#{session.id}\""
  end

  get '/destroy_session' do
    destroied_session_id = session.id
    session.destroy
    "The session (#{destroied_session_id}) has destroied.\n"
  end

  get '/check_session' do
    if session[:started] then
      "You started the session.\nYour session ID is \"#{session.id}\""
    else
      "Did you start a session?\n"
    end
  end

end
