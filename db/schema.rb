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

ActiveRecord::Schema.define(version: 20150816234509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "error_logs", force: :cascade do |t|
    t.date     "date"
    t.text     "transaction_name"
    t.string   "error"
    t.string   "file_name"
    t.integer  "file_row"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "tennant_id"
    t.string   "description"
    t.decimal  "amount",       precision: 10, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "invoice_type"
  end

  create_table "owners", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "country"
    t.string   "postal_code"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.decimal  "monthly_charge", precision: 10, scale: 2
  end

  create_table "tennants", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "property_id"
    t.string   "email"
    t.integer  "phone"
    t.string   "notes"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "transaction_description"
    t.date     "invoice_last_run"
    t.date     "start_date"
    t.date     "end_date"
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "generated_by"
    t.decimal  "amount",           precision: 10, scale: 2, default: 0.0
    t.string   "transaction_type"
    t.date     "date"
    t.integer  "tennant_id"
    t.string   "name"
    t.string   "category"
    t.integer  "owner_id"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
