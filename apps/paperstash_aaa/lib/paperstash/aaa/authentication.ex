defmodule PaperStash.Authentication do
  @moduledoc ~S"""
  """

  alias PaperStash.User
  alias PaperStash.Repository, as: R

  def authenticate(email, password) do
    case R.get_by(User, email: email) do
      %User{encrypted_password: expected} = user ->
        if Comeonin.Ecto.Password.valid?(password, expected) do
          {:ok, user}
        else
          {:error, :password}
        end
      _ ->
        {:error, :email}
    end
  end
end
