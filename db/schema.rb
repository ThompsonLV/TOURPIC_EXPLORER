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

ActiveRecord::Schema[7.0].define(version: 2023_08_29_124225) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "content"
    t.boolean "success"
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "monuments", force: :cascade do |t|
    t.string "title"
    t.string "short_description"
    t.text "long_description"
    t.integer "points"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.bigint "monument_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monument_id"], name: "index_questions_on_monument_id"
  end

  create_table "user_answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "answer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_user_answers_on_answer_id"
    t.index ["user_id"], name: "index_user_answers_on_user_id"
  end

  create_table "user_monuments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "monument_id", null: false
    t.boolean "favoris"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monument_id"], name: "index_user_monuments_on_monument_id"
    t.index ["user_id"], name: "index_user_monuments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "questions", "monuments"
  add_foreign_key "user_answers", "answers"
  add_foreign_key "user_answers", "users"
  add_foreign_key "user_monuments", "monuments"
  add_foreign_key "user_monuments", "users"
end
