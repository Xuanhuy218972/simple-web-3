module Frack 
  class BaseController
    attr_reader :request, :session, :current_user

    def initialize(env)
      @request = Rack::Request.new(env)
      @session = @request.session
      @flash_message = @session && @session.delete('flash')
      @current_user = defined?(User) && @session ? User.find_by_id(@session['user_id']) : nil
    end

    def render(view)
      render_template('layouts/application') do
        render_template(view)
      end
    end

    def render_template(path, &block)
      Tilt.new(file(path)).render(self, &block)
    end

    def file(path)
      Dir[File.join('app', 'views', "#{path}.html.*")].first
    end
  end
end