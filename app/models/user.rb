module PaperStash
  class User < PaperStash::Model(:users)
    class Activity < PaperStash::Model(:activity_by_user)
    end
  end
end
