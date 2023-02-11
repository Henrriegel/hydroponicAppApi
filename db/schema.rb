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

ActiveRecord::Schema[7.0].define(version: 2022_10_07_070542) do
  create_table "lectures", charset: "utf8mb4", force: :cascade do |t|
    t.string "roomTemperature"
    t.string "temperature1"
    t.string "temperature2"
    t.string "ph"
    t.string "roomHumidity"
    t.bigint "sensor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sensor_id"], name: "index_lectures_on_sensor_id"
  end

  create_table "parameters", charset: "utf8mb4", force: :cascade do |t|
    t.string "temperature"
    t.string "roomTemperature"
    t.string "ph"
    t.string "humidity"
    t.bigint "plant_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_parameters_on_plant_id"
    t.index ["user_id"], name: "index_parameters_on_user_id"
  end

  create_table "plants", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_plants_on_name", unique: true
  end

  create_table "sensors", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "mac_address"
    t.string "activate"
    t.bigint "user_id", null: false
    t.bigint "plant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mac_address"], name: "index_sensors_on_mac_address", unique: true
    t.index ["plant_id"], name: "index_sensors_on_plant_id"
    t.index ["user_id"], name: "index_sensors_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "nickname"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
  end

  add_foreign_key "lectures", "sensors"
  add_foreign_key "parameters", "plants"
  add_foreign_key "parameters", "users"
  add_foreign_key "sensors", "plants"
  add_foreign_key "sensors", "users"
end
