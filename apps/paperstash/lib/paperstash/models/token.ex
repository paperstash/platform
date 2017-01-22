import EctoEnum, only: [defenum: 2]

defenum PaperStash.TokenType,
  one_time_login_token: "one_time_login_token",
  email_verification_token: "email_verification_token",
  password_reset_token: "password_reset_token"

defmodule PaperStash.Token do
  @moduledoc ~S"""
  """

  use PaperStash.Model

  schema "tokens" do
    # Tokens are (exclusively) owned by a user.
    belongs_to :owner, Knowledge.User

    # Refer to PaperStash.TokenType for a list of permitted types.
    field :type, PaperStash.TokenType

    # Unguessable, but not necessarily globally unique string that identifies
    # the token.
    field :unguessable, :string

    field :expires_at, Timex.Ecto.DateTime
    field :revoked_at, Timex.Ecto.DateTime
    field :redeemed_at, Timex.Ecto.DateTime
  end
end
