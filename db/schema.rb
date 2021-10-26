# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_26_131158) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.string "event", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "result_id", null: false
    t.bigint "question_id", null: false
    t.string "value"
    t.boolean "correct", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["result_id"], name: "index_answers_on_result_id"
  end

  create_table "possession_tokens", force: :cascade do |t|
    t.string "value", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_possession_tokens_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email", null: false
    t.string "department", null: false
    t.text "avatar_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.string "avatar_name"
    t.string "gender"
    t.index ["discarded_at"], name: "index_questions_on_discarded_at"
  end

  create_table "refresh_tokens", force: :cascade do |t|
    t.string "token", null: false
    t.bigint "user_id", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "jti"
    t.index ["jti"], name: "index_refresh_tokens_on_jti"
    t.index ["token"], name: "index_refresh_tokens_on_token"
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "results", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "score", default: 0, null: false
    t.integer "time_duration", default: 30, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.citext "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "avatar_data"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "confirmed_at"
    t.integer "last_score", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["password_reset_token"], name: "index_users_on_password_reset_token"
  end

  add_foreign_key "activities", "users"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "results"
  add_foreign_key "possession_tokens", "users"
  add_foreign_key "refresh_tokens", "users"
  add_foreign_key "results", "users"
end
