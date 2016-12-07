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

ActiveRecord::Schema.define(version: 20161207223545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer  "hero_reputation"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "action"
  end

  create_table "npc_turns", force: :cascade do |t|
    t.integer  "npc_id"
    t.integer  "turn_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["npc_id"], name: "index_npc_turns_on_npc_id", using: :btree
    t.index ["turn_id"], name: "index_npc_turns_on_turn_id", using: :btree
  end

  create_table "npcs", force: :cascade do |t|
    t.string   "name"
    t.integer  "personality"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "game_id"
    t.integer  "turn_id"
    t.index ["game_id"], name: "index_npcs_on_game_id", using: :btree
    t.index ["turn_id"], name: "index_npcs_on_turn_id", using: :btree
  end

  create_table "responses", force: :cascade do |t|
    t.text     "content"
    t.text     "input"
    t.integer  "hero_reputation"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "pass"
    t.integer  "turn_id"
    t.index ["turn_id"], name: "index_responses_on_turn_id", using: :btree
  end

  create_table "turns", force: :cascade do |t|
    t.string   "status"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "input"
    t.string   "content"
    t.string   "result"
    t.index ["game_id"], name: "index_turns_on_game_id", using: :btree
  end

  add_foreign_key "npc_turns", "npcs"
  add_foreign_key "npc_turns", "turns"
  add_foreign_key "npcs", "games"
  add_foreign_key "npcs", "turns"
  add_foreign_key "responses", "turns"
  add_foreign_key "turns", "games"
end
