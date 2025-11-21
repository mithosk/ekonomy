class Init < ActiveRecord::Migration[8.1]
  def change
    create_table :years do |t|
      t.integer :number, null: false
      t.integer :target, null: false
    end

    add_index :years, :number, unique: true
  end
end
