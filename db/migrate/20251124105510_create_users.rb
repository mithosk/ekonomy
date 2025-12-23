class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    execute <<-SQL
        CREATE TYPE user_role AS ENUM ('ADMIN', 'OPERATOR');
    SQL

    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :full_name, null: false
      t.column :role, :user_role, null: false
      t.boolean :dashboard, null: false
      t.boolean :detection, null: false
      t.boolean :balancing, null: false
      t.boolean :expense, null: false
      t.boolean :category, null: false
    end

    add_index :users, :username, unique: true
  end
end
