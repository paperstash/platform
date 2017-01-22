alias PaperStash.Repository, as: R

admin = PaperStash.User.create(%{
  role: :admin,
  nickname: "Mike",
  email: "m.t.williams@live.com",
  verified_email_at: Timex.now,
  password: "12345678",
  personage: %{
    portrait: PaperStash.Gravatar.url("m.t.williams@live.com"),
    name: "Michael Williams",
    bio: "A guy.",
    organization: "Life",
    location: "Vancouver, BC",
    facebook_url: "https://www.facebook.com/profile.php?id=100004431391242",
    linkedin_url: "https://www.linkedin.com/in/michael-williams-7b5aa7aa",
    twitter_url: "http://twitter.com/__devbug",
    github_url: "http://github.com/mtwilliams",
    stackoverflow_url: "http://stackoverflow.com/users/1982393/michael-williams",
  }
})

user = PaperStash.User.create(%{
  nickname: "Dale Weiler",
  email: "weilercdale@gmail.com",
  verified_email_at: Timex.now,
  password: "12345678",
  personage: %{
    portrait: PaperStash.Gravatar.url("weilercdale@gmail.com"),
    name: "Dale Weiler",
    bio: "Digital Media Platform Engineer, Graphic Programmer, Games Enthusiast, Professional Troll",
    github_url: "https://github.com/graphitemaster"
  }
})

R.insert! %PaperStash.Follow {
  follower_id: user.id,
  followee_id: admin.id
}
