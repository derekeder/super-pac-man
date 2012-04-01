require "sinatra/base"
require "sinatra/reloader"
require "sinatra-initializers"
require "sinatra/json"
require "sequel"
require "uri"

module SuperPacMan
  class Application < Sinatra::Base

    enable :logging, :sessions
    enable :dump_errors, :show_exceptions if development?

    configure :development do
      register Sinatra::Reloader
    end

    register Sinatra::Initializers

    before do
      session[:locale] = params[:locale] if params[:locale]
    end

    use Rack::Logger
    use Rack::Session::Cookie

    helpers HtmlHelpers
    helpers SuperPacMan::ViewHelpers
    helpers Sinatra::JSON


    get "/" do
      @current_menu = "home"
      haml :index
    end
  end
end

