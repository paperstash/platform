defmodule PaperStash.Repo.Migrations.Setup do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :role, :integer

      add :nickname, :string

      add :email, :string
      add :verified_email_at, :datetime

      add :encrypted_password, :string

      add :github, :integer
      add :twitter, :integer

      add :created_at, :datetime
      add :updated_at, :datetime
    end

    create unique_index :users, [:email]

    create table(:people, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :user_id, references(:users, type: :binary_id)

      add :portrait, :string

      add :name, :string
      add :bio, :string
      add :location, :string
      add :organization, :string
      add :website, :string

      add :facebook_url, :string
      add :linkedin_url, :string
      add :twitter_url, :string
      add :github_url, :string
      add :stackoverflow_url, :string

      add :created_at, :datetime
      add :updated_at, :datetime
    end

    create table(:tokens, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :owner_id, references(:users, type: :binary_id)

      add :type, :integer
      add :unguessable, :string

      add :expires_at, :datetime
      add :revoked_at, :datetime
      add :redeemed_at, :datetime

      add :created_at, :datetime
      add :updated_at, :datetime
    end

    create table(:follows, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :follower_id, references(:users, type: :binary_id)
      add :followee_id, references(:users, type: :binary_id)

      add :created_at, :datetime
      add :updated_at, :datetime
    end
  end
end
