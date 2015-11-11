module PaperStash
  require 'env'
  require 'config'
  require 'version'
  require 'logger'
  require 'metrics'
  require 'database'
  require 'mailer'

  class Base  < Sinatra::Base
    set :environment, PaperStash.env.to_sym
    set :root, PaperStash.root

    # TODO(mtwilliams): Use Sprockets (via PaperStash::Assets::Environment).
    enable :static
    set :public_folder, 'public'

    # Don't use the built-in web-server.
    set :run, false

    # Errors are bubbled so they can be handled as per `config/environment.rb`.
    set :dump_errors, false
    set :raise_errors, true
    set :show_exceptions, false

    # Fuck you, IE9.
    disable :method_override

    # FIXME(mtwilliams): Re-enable.
    # set :protection, session: true

    set :views, 'app/views'

    # Use app/views/_layouts/default.html.erb as the default layout.
    set :erb, :layout => :'_layouts/default'

    helpers do
      def partial(name)
        erb name.to_sym, :layout => false
      end
    end

    before do
      # # TODO(mtwilliams): Use PaperStash::Session.
      # if session['user.id']
      #   @session = OpenStruct.new({user: User[session['user.id'].to_i]}
      # else
      #   @session = OpenStruct.new({})
      # end
    end
  end

  # Concerns:
  # puts "Loading concerns..."
  [*Dir.glob('concerns/**.rb')].each do |path|
    concern = path.sub('concerns/','').sub('.rb','').camelize.constantize
    # puts " => #{concern}"
    require path
  end

  # Models:
  # puts "Loading models..."
  require 'model'
  [*Dir.glob('models/**.rb')].each do |path|
    model = path.sub('models/','').sub('.rb','').camelize.constantize
    # puts " => #{model}"
    require path
  end

  # Helpers:
  # puts "Loading helpers..."
  [*Dir.glob('helpers/**.rb')].each do |path|
    helper = path.sub('helpers/','').sub('.rb','').camelize.constantize
    # puts " => #{helper}"
    require path
  end

  # Presenters:
  # puts "Loading presenters..."
  [*Dir.glob('presenters/**.rb')].each do |path|
    presenter = path.sub('presenters/','').sub('.rb','').camelize.constantize
    # puts " => #{presenter}"
    require path
  end

  # Views:

  # Services:
  # puts "Loading service objects..."
  [*Dir.glob('services/**.rb')].each do |path|
    service = path.sub('services/','').sub('.rb','').camelize.constantize
    # puts " => #{service}"
    require path
  end

  # Mailers:
  # puts "Loading mailers..."
  [*Dir.glob('mailers/**.rb')].each do |path|
    mailer = path.sub('mailers/','').sub('.rb','').camelize.constantize
    # puts " => #{mailer}"
    require path
  end

  class App < PaperStash::Base
    # Assets are handled by Sprockets.
    require 'assets'
    set :assets, assets = PaperStash::Assets.environment
    get %r{^/(?:fonts|images|styles|scripts)} do
      env['PATH_INFO'].sub!(%r{^/(fonts|images|styles|scripts)}, '')
      settings.assets.call(env)
    end

    # Controllers:
    # puts "Loading controllers..."
    require 'controller'
    [*Dir.glob('controllers/**.rb')].each do |path|
      controller = path.sub('controllers/','').sub('.rb','').camelize.constantize
      # puts " => #{controller}"
      require path
      use path.sub('controllers/','').sub('.rb','').camelize.constantize
    end
  end
end
