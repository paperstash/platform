module PaperStash
  class MeEndpoint < PaperStash::Endpoint
    before do
      authenticate!
    end

    get '/v1/me' do
      redirect to("/v1/users/#{@credentials.user.id}")
    end

    post '/v1/me/verify', :auth => true do
      param :token, String, required: true

      if Users.verify(@credentials.user, params[:token])
        json {}
      else
        status 403
        json {error: 'invalid_or_expired_token'}
      end
    end

    post '/v1/me/verify/request', :auth => true do
      Users.reverify(@credentials.user)
      json {}
    end
  end
end
