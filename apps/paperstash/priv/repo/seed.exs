michael_williams = %PaperStash.Person{
  portrait: Exgravatar.gravatar_url("m.t.williams@live.com"),
  name: "Michael Williams",
  bio: "A guy.",
  organization: "Life",
  location: "Vancouver, BC",
  facebook_url: "https://www.facebook.com/profile.php?id=100004431391242",
  linkedin_url: "https://www.linkedin.com/in/michael-williams-7b5aa7aa",
  twitter_url: "http://twitter.com/__devbug",
  github_url: "http://github.com/mtwilliams",
  stackoverflow_url: "http://stackoverflow.com/users/1982393/michael-williams",
} |> PaperStash.Repo.insert!

admin = %PaperStash.User {
  role: :admin,
  nickname: "Mike",
  email: "m.t.williams@live.com",
  verified_email_at: Timex.DateTime.now,
  personage: michael_williams
}
