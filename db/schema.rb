ActiveRecord::Schema.define(version: 2020_11_27_150900) do
  create_table "live_companions", force: :cascade do |t|
    t.string "artist_name"
    t.string "live_name"
    t.date "schedule"
    t.text "live_memo"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "created_at"], name: "index_live_companions_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_live_companions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "introduction"
    t.string "sex"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "live_companions", "users"
end
