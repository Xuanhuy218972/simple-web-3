$LOAD_PATH.unshift << '.'

require 'rack/session'

require_relative 'lib/frack'
require_relative 'app/controllers/users_controller'
require_relative 'app/controllers/home_controller'
require_relative 'app/controllers/sessions_controller'
require_relative 'app/models/user'
 

use Rack::Static, root: 'public', urls: ['/css', '/images', '/js']
 

use Rack::Session::Cookie, 
    key:'rack.session',
    path: '/',
    secret: 'your_secret_key_0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'

use Frack::Router do
    get "/" => "home#show"
    get '/sign_up' => 'users#new'
    post '/users/sign_up' => 'users#create'
    post '/sign_in' => 'sessions#create'
    delete '/sign_out' => 'sessions#destroy'
    get '/users' => 'users#index'
end

run Frack::Application

