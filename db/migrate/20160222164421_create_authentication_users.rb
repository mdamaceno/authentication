class CreateAuthenticationUsers < ActiveRecord::Migration
  def change
    create_table :authentication_users do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :email, null: false
      t.string :password
      t.boolean :status, default: false
      t.string :auth_token

      t.timestamps null: false
    end
    add_index :authentication_users, :email, unique: true
    add_index :authentication_users, :slug, unique: true
  end
end
