module PaperStash
  class StatusEndpoint < PaperStash::Endpoint
    get "/" do
      redirect(to("/v1/status"))
    end

    get "/v1/status" do
      # Refer to `lib/paperstash/status.rb`.
      Status.new.call(env)
    end
  end
end
