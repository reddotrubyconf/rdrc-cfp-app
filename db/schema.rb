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

ActiveRecord::Schema.define(version: 20170314113845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conferences", force: :cascade do |t|
    t.string   "name",          null: false
    t.datetime "cfp_closes_at", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "papers", force: :cascade do |t|
    t.string   "title",                        null: false
    t.text     "abstract",                     null: false
    t.integer  "status",           default: 1, null: false
    t.integer  "user_id"
    t.integer  "speaker_slot",     default: 1, null: false
    t.text     "outline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "scrubbed_outline"
    t.index ["user_id"], name: "index_papers_on_user_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "paper_id"
    t.integer  "score",      null: false
    t.text     "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paper_id"], name: "index_reviews_on_paper_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   null: false
    t.string   "email",                  null: false
    t.text     "bio"
    t.string   "avatar_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",       default: 0
  end

  add_foreign_key "papers", "users"
end
