import EctoEnum, only: [defenum: 2]

defenum PaperStash.UserRole,
  user: "user",
  contributor: "contributor",
  moderator: "moderator",
  admin: "admin"

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

    # Passwords are stored using BCrypt.
    field :password, :string, virtual: true
    field :encrypted_password, Comeonin.Ecto.Password

    # Social media they've connected or logged in through.
    field :github, :integer
    field :twitter, :integer

    # People as a generic entity are modeled separately, as the vast majority
    # of authors will not be a part of our community.
    has_one :personage, PaperStash.Person

    # Users can subscribe to one another to receive notifications about their
    # activies, i.e. authoring, contributing, and commenting.

    # Users followed by this user.
    has_many :follows, PaperStash.Follow, foreign_key: :follower_id
    has_many :followees, through: [:follows, :followee]

    # Users following this user.
    has_many :following, PaperStash.Follow, foreign_key: :followee_id
    has_many :followers, through: [:following, :follower]
  end

  @required ~W{nickname email password}a
  @optional ~W{role}a

  def create(params) when is_list(params), do: create(params |> Map.new)
  def create(params) when is_map(params) do
    # TODO(mtwilliams): Deduplicate against existing people.
    # TODO(mtwillaims): Associate with Gravatar, if it exists.
    %PaperStash.User{}
    |> cast(params, @required ++ @optional)
    |> cast_assoc(:personage, required: true)
    # HACK(mtwilliams): Manually cast because Ecto doesn't want to.
    |> put_change(:encrypted_password, encrypt_password(params.password))
    |> validate
    |> R.insert!
  end

  defp validate(user_or_changeset) do
    user_or_changeset
    |> validate_required(@required)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
  end

  # SMELL(mtwilliams): We should extract authentication out...
  def authenticate(email: email, password: password) do
    case R.get_by(PaperStash.User, email: email) do
      %PaperStash.User{encrypted_password: expected} = user ->
        if Comeonin.Ecto.Password.valid?(password, expected) do
          {:ok, user}
        else
          {:error, :invalid_password}
        end
      _ ->
        {:error, :invalid_email}
    end
  end

  defp encrypt_password(password) do
    {:ok, encrypted} = Comeonin.Ecto.Password.cast(password)
    encrypted
  end

  def follows(%PaperStash.User{id: id} = _user) do
    PaperStash.Follow.all
    |> where([f: 0], f.follower_id == ^id)
  end

  def following(%PaperStash.User{id: id} = _user) do
    PaperStash.Follow.all
    |> where([f: 0], f.followee_id == ^id)
  end
end
