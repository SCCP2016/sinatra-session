require 'sinatra'

# 名前を保存するリポジトリ
module NameRepository
  @@names = {}

  def self.add(session_id, name)
    @@names[session_id] = name
  end

  def self.find(session_id)
    @@names[session_id]
  end
end

class MainApp < Sinatra::Base
  configure do
    # セッション管理を有効にする
    enable :sessions
  end

  post '/namepost' do
    posted_name = request.body.read

    # セッションIDを生成して名前と一緒に保存
    session_id = Digest::SHA256.hexdigest(rand.to_s)
    session[:id] = session_id
    NameRepository.add(session_id, posted_name)

    # レスポンス
    status 201
    "OK, I've memorized you.\n"
  end

  get '/namepost' do
    session_id = session[:id]
    saved_name = NameRepository.find(session_id)

    # 名前が保存されていない場合は別のメッセージ
    if !saved_name
    return "Who are you???\n"
    end

    "Oh! My friend #{saved_name}!!\n"
  end

end
