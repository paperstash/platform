Sequel.migration do
  change do
    create_table :people do
      primary_key :id

      column :avatar, :text
      column :name, :text
      column :email, :text
      column :organization, :text
      column :location, :text
      column :biography, :text
      column :website, :text

      index :name
      index :email
    end

    create_table :users do
      primary_key :id

      column :login, :text, unique: true, null: false
      column :email, :text, unique: true, null: false
      column :password, :text, null: true

      foreign_key :personage, :people, on_delete: :set_null

      column :verified, :boolean, default: false
      column :contributor, :boolean, default: false

      index :login
      index :email
      index :password
    end

    create_table :sessions do
      primary_key :id

      foreign_key :user_id, :users, on_delete: :cascade

      column :started_at, :timestamp
      column :expires_at, :timestamp
      column :invalidated_at, :timestamp

      index :started_at
      index :expires_at
      index :invalidated_at
    end

    create_table :redeemable_tokens do
      primary_key :id

      foreign_key :user_id, :users, on_delete: :cascade

      column :type, :text
      column :token, :text

      column :expires_at, :timestamp
      column :redeemed_at, :timestamp

      index [:type, :token]
      index :expires_at
      index :redeemed_at
    end

    create_table :papers do
      primary_key :id

      column :title, :text
      column :description, :text

      column :preview, :text
      column :pdf, :text

      foreign_key :uploader_id, :users, on_delete: :set_null
      column :uploaded_at, :timestamp
    end

    create_table :authors_of_papers do
      primary_key :id

      foreign_key :author_id, :people, on_delete: :cascade
      foreign_key :paper_id, :papers, on_delete: :cascade

      column :primary, :boolean
    end

    create_table :stars_on_papers do
      primary_key :id

      foreign_key :starrer_id, :users, on_delete: :cascade
      foreign_key :paper_id, :papers, on_delete: :cascade
    end

    create_table :follows do
      primary_key :id

      foreign_key :followee_id, :users, on_delete: :cascade
      foreign_key :follower_id, :users, on_delete: :cascade
    end

    create_table :activity_by_user do
      primary_key :id

      foreign_key :user_id, :users, on_delete: :cascade

      column :action, :text
      column :subject, :hstore
    end
  end
end
