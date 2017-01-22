use Mix.Config

config :paperstash_notifications, PaperStash.Notifications.Emailer,
  adapter: Swoosh.Adapters.Local

config :swoosh,
  serve_mailbox: true,
  preview_port: 7777
