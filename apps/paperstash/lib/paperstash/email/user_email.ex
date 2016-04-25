defmodule PaperStash.UserEmail do
  @moduledoc ~S"""
  """

  import Swoosh.Email

  def welcome(user) do
    new
    |> to({user.personage.name, user.email})
    |> from({"PaperStash", "hi@paperstash.org"})
    |> subject("Welcome to PaperStash!")
    |> text_body("Hello #{user.nickname},\n\nWelcome to PaperStash.\n\nMike")
  end
end
