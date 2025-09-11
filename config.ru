$LOAD_PATH.unshift << '.'

require_relative 'lib/frack'
require_relative 'app/controllers/application_controller'
require_relative 'app/controllers/home_controller'
require_relative 'app/controllers/sessions_controller'
require_relative 'app/models/user'
require_relative 'rack/session/cookie'
require_relative 'lib/middleware/logger_middleware'

use Rack::Static, root: 'public', urls: ['/css', '/images', '/js']
use LoggerMiddleware 

use Rack::Session::Cookie, 
    key:'rack.session',
    path: '/',
    secret: 'your_secret_key_0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'

run Frack::Application

