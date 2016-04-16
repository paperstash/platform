# TODO(mtwiliams: Fork off EctoEnum to allow storage as strings or integers,
# then store roles as strings. See https://github.com/gjaldon/ecto_enum/issues/4.
import EctoEnum, only: [defenum: 2]

defenum PaperStash.UserRole, user: 1, contributor: 2, moderator: 3, admin: 4

defmodule PaperStash.User do
  @moduledoc ~S"""
  """

  use PaperStash.Model

  schema "users" do
    # Refer to PaperStash.UserRole for a list of permitted roles.
    field :role, PaperStash.UserRole, default: :user

    # Read this http://blog.skylight.io/whats-in-a-name/.
    field :nickname, :string

    # Private email address.
    field :email, :string, unique: true
    field :verified_email_at, Timex.Ecto.DateTime

    # TODO(mtwilliams): Provide a custom BCrypt type in line with `Ecto.Type`.
    # Passwords are stored using BCrypt.
    field :password_hash, :string

    # Social media they've connected or logged in through.
    field :github, :integer
    field :twitter, :integer

    # People as a generic entity are modeled separately, as the vast majority
    # of authors will not be a part of our community. At least initially.
    has_one :personage, PaperStash.Person
  end
end
