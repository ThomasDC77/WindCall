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

ActiveRecord::Schema[7.0].define(version: 2022_11_29_155755) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "spot_weathers", force: :cascade do |t|
    t.datetime "time"
    t.bigint "spot_id", null: false
    t.bigint "weather_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_spot_weathers_on_spot_id"
    t.index ["weather_id"], name: "index_spot_weathers_on_weather_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.text "description"
    t.string "difficulty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weathers", force: :cascade do |t|
    t.float "wind_force"
    t.float "wind_direction"
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "spot_weathers", "spots"
  add_foreign_key "spot_weathers", "weathers"
end
