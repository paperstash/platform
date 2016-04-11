module PaperStash
  class AuthorizationSerializer < PaperStash::Serializer(Authorization)
    attribute :token
    attribute :scope
  end
end
