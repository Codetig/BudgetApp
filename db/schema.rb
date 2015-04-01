# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150330001433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "expense"
    t.decimal  "proj_val",   precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "period1",    precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "period2",    precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "period3",    precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "period4",    precision: 10, scale: 2, default: 0.0, null: false
    t.text     "desc"
    t.string   "smiley"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "month_id"
  end

  create_table "months", force: :cascade do |t|
    t.string   "name"
    t.date     "month_date"
    t.decimal  "projected_income", precision: 10, scale: 2
    t.decimal  "projected_exp",    precision: 10, scale: 2
    t.decimal  "actual_income",    precision: 10, scale: 2
    t.decimal  "actual_exp",       precision: 10, scale: 2
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "budget_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.string   "cell_num"
    t.string   "password"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "email",                  default: "", null: false
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
