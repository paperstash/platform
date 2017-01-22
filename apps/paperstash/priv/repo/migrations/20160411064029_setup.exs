defmodule PaperStash.Migrations.Setup do
  use Ecto.Migration

  @extensions ~W{
    pg_stat_statements
    pgrowlocks
    pgstattuple
    pg_freespacemap
    pg_buffercache

    uuid-ossp

    plpgsql

    pg_trgm
    fuzzystrmatch

    btree_gin
    btree_gist

    intarray
  }

  def up do
    for extension <- @extensions do
      execute "CREATE EXTENSION IF NOT EXISTS \"#{extension}\";"
    end

    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :role, :string

      add :nickname, :string

      add :email, :string
      add :verified_email_at, :datetime

      add :encrypted_password, :string

      add :github, :integer
      add :twitter, :integer

      add :created_at, :timestamp
      add :updated_at, :timestamp
    end

    create unique_index :users, [:email]
    create unique_index :users, [:github]
    create unique_index :users, [:twitter]

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

      add :created_at, :timestamp
      add :updated_at, :timestamp
    end

    create table(:tokens, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :owner_id, references(:users, type: :binary_id)

      add :type, :string
      add :unguessable, :string

      add :expires_at, :datetime
      add :revoked_at, :datetime
      add :redeemed_at, :datetime

      add :created_at, :timestamp
      add :updated_at, :timestamp
    end

    create index :tokens, [:type]
    create index :tokens, [:unguessable]

    create table(:follows, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :follower_id, references(:users, type: :binary_id)
      add :followee_id, references(:users, type: :binary_id)

      add :created_at, :timestamp
      add :updated_at, :timestamp
    end
  end
end
