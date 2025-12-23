# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_11_24_105510) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "user_role", ["ADMIN", "OPERATOR"]

  create_table "users", force: :cascade do |t|
    t.boolean "balancing", null: false
    t.boolean "category", null: false
    t.boolean "dashboard", null: false
    t.boolean "detection", null: false
    t.boolean "expense", null: false
    t.string "full_name", null: false
    t.string "password_digest", null: false
    t.enum "role", null: false, enum_type: "user_role"
    t.string "username", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "years", force: :cascade do |t|
    t.integer "number", null: false
    t.integer "target", null: false
    t.index ["number"], name: "index_years_on_number", unique: true
  end
end
