defmodule PaperStash.Person do
  @moduledoc ~S"""
  """

  use PaperStash.Model

  schema "people" do
    # Refer to `PaperStash.User`.
    belongs_to :user, PaperStash.User

    # TODO(mtwilliams): Store our own copies of portraits.
    field :portrait, :string, default: "/assets/images/silhouette.png"

    # Full name.
    field :name, :string

    # Short biography, garnered from social media if possible.
    field :bio, :string

    # Where they work.
    field :organization, :string

    # Where they live.
    field :location, :string

    # Their personal website or blog.
    field :website, :string

    # Social media.
    field :facebook_url, :string
    field :linkedin_url, :string
    field :twitter_url, :string
    field :github_url, :string
    field :stackoverflow_url, :string
  end
end
