class PaperStash
  class SpaController < PaperStash::Controller
    get '/' do
      erb 'spa'
    end
  end
end
