class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, index: true
      t.string :last_name, index: true
      t.boolean :admin, default: false
      t.string :avatar
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true

    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
    end

    create_table :categories do |t|
      t.string :name, index: true
      t.text :description
      t.timestamps null: false
    end

    create_table :books do |t|
      t.references :category
      t.string :title, index: true
      t.string :author, index: true
      t.datetime :published_date, index: true
      t.integer :total_page
      t.timestamps null:false
    end

    create_table :book_images do |t|
      t.references :book
      t.string :image
      t.timestamps
    end

    create_table :activities do |t|
      t.belongs_to :trackable, polymorphic: true
      t.belongs_to :owner, polymorphic: true
      t.string  :key
      t.text    :parameters
      t.belongs_to :recipient, polymorphic: true
      t.timestamps null: false
    end

    create_table :likes do |t|
      t.references :user
      t.references :activity
      t.timestamps null: false
    end

    create_table :requests do |t|
      t.references :user, index: true
      t.string :book_title, index: true
      t.string :book_author
      t.string :url
      t.boolean :status, default: false
      t.timestamps null: false
    end

    create_table :user_books do |t|
      t.references :user
      t.references :book
      t.string :status
      t.timestamps null: false
    end

    create_table :reviews do |t|
      t.references :user
      t.references :book
      t.text :content
      t.integer :rate
      t.timestamps null: false
    end

    create_table :comments do |t|
      t.references :user
      t.references :review
      t.text :content
    end

    create_table :favorites do |t|
      t.references :user
      t.references :book
      t.timestamps null: false
    end
  end
end
