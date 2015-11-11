module PaperStash
  class HomeController < PaperStash::Controller
    get "/" do
      erb :'home'
    end
  end
end
