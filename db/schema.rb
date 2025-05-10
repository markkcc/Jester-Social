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

ActiveRecord::Schema[8.0].define(version: 2025_05_10_211328) do
  create_table "bonks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bonkable_type"
    t.integer "bonkable_id"
    t.index ["bonkable_type", "bonkable_id"], name: "index_bonks_on_bonkable_type_and_bonkable_id"
    t.index ["user_id"], name: "index_bonks_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "jest_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "honks_count", default: 0, null: false
    t.integer "bonks_count", default: 0, null: false
    t.index ["jest_id"], name: "index_comments_on_jest_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "honks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "honkable_type"
    t.integer "honkable_id"
    t.index ["honkable_type", "honkable_id"], name: "index_honks_on_honkable_type_and_honkable_id"
    t.index ["user_id"], name: "index_honks_on_user_id"
  end

  create_table "jests", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "audience", default: "circus", null: false
    t.integer "honks_count", default: 0, null: false
    t.integer "bonks_count", default: 0, null: false
    t.index ["audience"], name: "index_jests_on_audience"
    t.index ["user_id"], name: "index_jests_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_sessions_on_user_id_and_created_at", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.string "profile_picture"
    t.string "identity", default: "jester", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "bonks", "users"
  add_foreign_key "comments", "jests"
  add_foreign_key "comments", "users"
  add_foreign_key "honks", "users"
  add_foreign_key "jests", "users"
  add_foreign_key "sessions", "users"
end
