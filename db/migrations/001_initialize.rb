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
      column :blog, :text

      index :email
    end

    create_table :users do
      primary_key :id

      column :nickname, :text, null: false
      column :email, :text, unique: true, null: false
      column :password, :text, null: true

      foreign_key :personage, :people, on_delete: :set_null

      column :verified, :boolean, default: false
      column :contributor, :boolean, default: false

      index [:email, :password]
    end

    create_table :sessions do
      primary_key :id

      foreign_key :user_id, :users, on_delete: :cascade

      column :started_at, :datetime
      column :expires_at, :datetime
      column :invalidated_at, :datetime
    end

    create_table :tokens do
      primary_key :id

      foreign_key :user_id, :users, on_delete: :cascade

      column :type, :text
      column :unguessable, :text

      column :invalidated_at, :datetime
      column :expires_at, :datetime
      column :redeemed_at, :datetime

      index [:type, :unguessable]
    end

    create_table :papers do
      primary_key :id

      column :title, :text
      column :description, :text

      column :preview, :text
      column :pdf, :text

      foreign_key :uploader_id, :users, on_delete: :set_null
      column :uploaded_at, :datetime
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

      column :at, :datetime
      column :action, :text
      column :subject, :hstore
    end
  end
end
