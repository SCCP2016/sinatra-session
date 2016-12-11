ENV['RACK_ENV'] = 'test'

require './src/app'
require 'test/unit'
require 'rack/test'

class MainAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    MainApp
  end

  def test_it_says_who_are_you
    get '/namepost'

    assert last_response.ok?, 'Status code is not 200.'
    assert_equal last_response.body, "Who are you???\n"
  end

  def test_it_saves_new_name_if_didnt_saved
    post '/namepost', 'some_name'

    assert last_response.created?, 'Status code is not 201'
    assert_equal last_response.body, "OK, I've memorized you.\n"
  end
  
  def test_it_greets_with_name_if_session_saved
    post '/namepost', 'some_name'
    get '/namepost', {}, 'rack.session' => last_request.env['rack.session']

    assert last_response.ok?, 'Status code is not 200.'
    assert_equal last_response.body, "Oh! My friend some_name!!\n"
  end

  def test_it_says_error_if_posted_empty_body
    post '/namepost', ''

    assert last_response.bad_request?, 'Status code is not 400'
    assert_equal last_response.body, "Posted name is empty.\n"
  end
  
  def test_it_wonders_if_posted_name_is_not_saved_name
    post '/namepost', 'some_name'
    get '/namepost', {}, 'rack.session' => last_request.env['rack.session']
    post '/namepost', 'other_name', 'rack.session' => last_request.env['rack.session']

    assert last_response.ok?, 'Status code is not 200.'
    assert_equal last_response.body, "other_name? I memorized your name as some_name.\n"
  end

  def test_it_understands_if_posted_name_is_saved_name
    post '/namepost', 'some_name'
    get '/namepost', {}, 'rack.session' => last_request.env['rack.session']
    post '/namepost', 'some_name', 'rack.session' => last_request.env['rack.session']

    assert last_response.ok?, 'Status code is not 200.'
    assert_equal last_response.body, "I remember you!!\n"
  end
end
