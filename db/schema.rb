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

ActiveRecord::Schema.define(version: 2021_12_12_034927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_schedules", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "room_id", null: false
    t.bigint "time_block_id", null: false
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_schedules_on_event_id"
    t.index ["room_id"], name: "index_event_schedules_on_room_id"
    t.index ["time_block_id"], name: "index_event_schedules_on_time_block_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "organizer_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "capacity"
    t.boolean "isCanceled", default: false
    t.string "uid"
    t.index ["organizer_id"], name: "index_events_on_organizer_id"
    t.index ["room_id"], name: "index_events_on_room_id"
  end

  create_table "organizers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.index ["name"], name: "index_organizers_on_name", unique: true
  end

  create_table "participant_schedules", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_participant_schedules_on_event_id"
    t.index ["participant_id"], name: "index_participant_schedules_on_participant_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.index ["email"], name: "index_participants_on_email", unique: true
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location"], name: "index_rooms_on_location"
    t.index ["name"], name: "index_rooms_on_name"
  end

  create_table "time_blocks", force: :cascade do |t|
    t.string "start_time"
    t.string "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["start_time"], name: "index_time_blocks_on_start_time"
  end

  add_foreign_key "event_schedules", "events"
  add_foreign_key "event_schedules", "rooms"
  add_foreign_key "event_schedules", "time_blocks"
  add_foreign_key "events", "organizers"
  add_foreign_key "events", "rooms"
  add_foreign_key "participant_schedules", "events"
  add_foreign_key "participant_schedules", "participants"
end
