class PaperStash
  class AuthorizationsController < PaperStash::Controller
    helpers do
      def redirect_with_code(redirect, code)
        redirect = Addressable::URI.parse(redirect)
        redirect.query_values[:code] = code
        redirect.to_s
      end

      def redirect_is_safe!(redirect)
        raise OAuth2::UnsafeRedirect.new(redirect) unless redirect_is_safe?(redirect)
      end

      def redirect_is_safe?(redirect)
        # TODO(mtwilliams): Only allow redirects in the same fashion as Github.
        # Refer to https://developer.github.com/v3/oauth/#redirect-urls or any
        # other standards complaint OAuth2 implementation.
        false
      end

      def scope_is_valid!(scope)
        raise OAuth2::InvalidScope.new(scope - GRANTS) unless scope_is_valid?(scope)
      end

      def scope_is_valid?(scope)
        (scope - GRANTS).empty?
      end
    end

    get "/ouath2/authorize" do
      halt 401 unless @session

      param :client,   String, required: true
      param :state,    String, required: true
      param :redirect, String
      param :scope,    Array,  required: true

      @client = OAuth2::Client.find!(id: params[:client])
      @state = params[:state]

      @redirect = params[:redirect] || client.callback
      redirect_is_safe! @redirect

      @scope = params[:scope].map(&:downcase)
      scope_is_valid! @scope

      # INSECURE(mtwilliams): Store an unguessable token?
      json {}
    end

    post "/oauth2/authorize" do
      halt 403 unless @session

      param :client_id, String, required: true
      param :state,     String, required: true
      param :redirect,  String
      param :scope,     Array,  required: true

      # TODO(mtwilliams): Handle as a special case.
      @client = OAuth2::Client.find!(id: params[:client_id])
      @state = params[:state]

      @redirect = params[:redirect] || client.callback
      redirect_is_safe! @redirect

      @scope = params[:scope].map(&:downcase)
      scope_is_valid! @scope

      @authorization = OAuth2::Authorization.create(user: @session.owner,
                                                    client: @client,
                                                    # TODO(mtwilliams): Hash |code| and |state| together?
                                                    code: SecureRandom.hex(24),
                                                    state: params[:state],
                                                    scope: @scope,
                                                    token: SecureRandom.hex(32))

      json {redirect: redirect_with_code(redirect, @authorization.code)}
    end

    post "/oauth2/complete" do
      param :client_id,     String, required: true
      param :client_secret, String, required: true
      param :code,          String, required: true
      param :state,         String, required: true

      @client = OAuth2::Client.find!(id: params[:client_id])
      raise OAuth2::IncorrectClientSecret unless @client.secret == params[:client_secret]

      @authorization = OAuth2::Authorization.find(code: params[:code])
      raise OAuth2::IncorrectState unless @authorization.state == params[:state]

      @authorization.complete!

      json AuthorizationSerializer.new(@authorization)
    end
  end
end
