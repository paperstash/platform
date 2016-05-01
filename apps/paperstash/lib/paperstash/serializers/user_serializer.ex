defmodule PaperStash.UserSerializer do
  @moduledoc ~S"""
  """

  use PaperStash.Serializer

  hook :before do
    PaperStash.Repo.preload(model, ~w(personage)a)
  end

  field :portrait, via: &(&1.personage.portrait)

  field :name, via: &(&1.personage.name)
  field :nickname

  field :bio, via: &(&1.personage.bio)
  field :location, via: &(&1.personage.location)
  field :organization, via: &(&1.personage.organization)

  field :email
  field :verified_email_at

  field :website, via: &(&1.personage.website)

  field :facebook_url, via: &(&1.personage.facebook_url)
  field :linkedin_url, via: &(&1.personage.linkedin_url)
  field :twitter_url, via: &(&1.personage.twitter_url)
  field :github_url, via: &(&1.personage.github_url)
  field :stackoverflow_url, via: &(&1.personage.stackoverflow_url)
end
