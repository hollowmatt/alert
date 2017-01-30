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

ActiveRecord::Schema.define(version: 20170130003033) do

  create_table "attachments", force: :cascade do |t|
    t.string   "file"
    t.integer  "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attachments", ["issue_id"], name: "index_attachments_on_issue_id"

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "issue_id"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "status_id"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id"
  add_index "comments", ["issue_id"], name: "index_comments_on_issue_id"

  create_table "distlists", force: :cascade do |t|
    t.integer  "priority_id"
    t.integer  "platform_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "follower_id"
  end

  add_index "distlists", ["follower_id"], name: "index_distlists_on_follower_id"
  add_index "distlists", ["platform_id"], name: "index_distlists_on_platform_id"
  add_index "distlists", ["priority_id"], name: "index_distlists_on_priority_id"

  create_table "followers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string   "subject"
    t.text     "issue"
    t.text     "impact"
    t.string   "ticket"
    t.text     "next_steps"
    t.integer  "platform_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "author_id"
    t.integer  "status_id"
    t.integer  "priority_id"
  end

  add_index "issues", ["author_id"], name: "index_issues_on_author_id"
  add_index "issues", ["platform_id"], name: "index_issues_on_platform_id"
  add_index "issues", ["priority_id"], name: "index_issues_on_priority_id"
  add_index "issues", ["status_id"], name: "index_issues_on_status_id"

  create_table "platforms", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "priorities", force: :cascade do |t|
    t.string "name"
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "role"
    t.integer  "platform_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "roles", ["platform_id"], name: "index_roles_on_platform_id"
  add_index "roles", ["user_id"], name: "index_roles_on_user_id"

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.string "color"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.datetime "archived_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
