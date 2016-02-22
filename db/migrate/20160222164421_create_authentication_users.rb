class CreateAuthenticationUsers < ActiveRecord::Migration
  def change
    create_table :authentication_users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email, null: false
      t.string :role, default: 'guest'
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.datetime :activated_at
      t.boolean :activated, default: false
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.string :authentication_token

      t.timestamps null: false
    end
    add_index :authentication_users, :email, unique: true
  end
end
