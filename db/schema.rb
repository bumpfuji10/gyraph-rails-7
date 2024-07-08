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

ActiveRecord::Schema[7.0].define(version: 2024_07_08_145405) do
  create_table "practice_record_details", force: :cascade do |t|
    t.integer "practice_record_id", null: false
    t.string "activity_title", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practice_record_id"], name: "index_practice_record_details_on_practice_record_id"
  end

  create_table "practice_records", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.date "practiced_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["practiced_date"], name: "index_practice_records_on_practiced_date"
    t.index ["user_id"], name: "index_practice_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", null: false
    t.text "profile"
    t.string "icon"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "practice_record_details", "practice_records"
  add_foreign_key "practice_records", "users"
end
