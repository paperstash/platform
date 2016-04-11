class PaperStash
  class SessionsController < PaperStash::Controller
    helpers do
      def leave
        redirect(to(params.fetch('redirect', '/')))
      end

      def leave_if_logged_in
        leave if @session
      end

      def login_via_token
        if token = Token.find(unguessable: params[:token])
          if token.redeem!
            @session = Session.create(owner: token.owner)
            leave
          else
            erb 'login_via_token', error: 'Login link has already used, or has expired.'
          end
        else
          erb 'login_via_token', error: 'Invalid login link.'
        end
      end

      def login_via_email_and_password
        if user = User.find(email: params[:email])
          if user.password == params[:password]
            @session = Session.create(owner: user)
          end
        end

        erb 'login', error: 'Unable to log you in.'
      end
    end

    # https://github.com/intridea/omniauth/wiki
    # http://stackoverflow.com/questions/798710/how-to-turn-a-ruby-hash-into-http-params
    # https://github.com/sporkmonger/addressable

    get "/login" do
      if :token.in? params
        login_via_token
      else
        leave_if_logged_in
        erb 'login'
      end
    end

    post "/login" do
      leave_if_logged_in
      login_via_email_and_password
    end

    # TODO(mtwilliams): Login via a third party.
    get "/login/via/:strategy" do |strategy|
      param :strategy, String, required: true, in: %w{github twitter}
      halt 501
    end

    get "/logout" do
      @session.invalidate! if @session
      redirect to('/')
    end
  end
end
