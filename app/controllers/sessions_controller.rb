module PaperStash
  class SessionsController < PaperStash::Controller
    get "/login" do
      erb 'sessions/new'
    end

    post "/login" do
      # ...
    end

    post "/logout" do
      # ...
    end
  end
end
