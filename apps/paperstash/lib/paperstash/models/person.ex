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

    # Where they live.
    field :location, :string

    # Where they work.
    field :organization, :string

    # Their personal website or blog.
    field :website, :string

    # Social media.
    field :facebook_url, :string
    field :linkedin_url, :string
    field :twitter_url, :string
    field :github_url, :string
    field :stackoverflow_url, :string
  end

  @required ~W{name}
  @profiles ~W{facebook_url linkedin_url twitter_url github_url stackoverflow_url}
  @optional ~W{portrait bio organization location website} ++ @profiles

  def changeset(person_or_changeset, changes \\ :empty) do
    person_or_changeset
    |> cast(changes, @required, ~w(user_id) ++ @optional)
    |> validate
  end

  defp validate(person_or_changeset) do
    person_or_changeset
  end
end
