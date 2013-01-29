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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130128150224) do

  create_table "dimensions", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "driver_gundams", :force => true do |t|
    t.integer  "driver_id"
    t.integer  "gundam_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "drivers", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "force_gundams", :force => true do |t|
    t.integer  "force_id"
    t.integer  "gundam_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "forces", :force => true do |t|
    t.string   "name"
    t.string   "summary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "gundam_photos", :force => true do |t|
    t.integer  "gundam_id"
    t.string   "image"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "is_verfied", :default => false
  end

  create_table "gundams", :force => true do |t|
    t.string   "name"
    t.string   "name_chs"
    t.string   "model"
    t.string   "usage_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "period_id"
    t.string   "name_jp"
    t.integer  "story_id"
    t.integer  "manufactory_id"
    t.string   "specifications"
    t.string   "internal_environment"
    t.string   "measurement"
    t.string   "weight"
    t.string   "armor"
    t.string   "output"
    t.string   "propulsion"
    t.string   "acceleration"
    t.string   "special_equipped"
    t.string   "default_weapon"
    t.string   "selected_weapon"
    t.string   "hand_weapon"
    t.string   "ranged_weapon"
    t.text     "summary"
    t.string   "avatar"
  end

  create_table "manufactories", :force => true do |t|
    t.integer  "gundam_id"
    t.string   "name"
    t.text     "summary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "periods", :force => true do |t|
    t.string   "name"
    t.string   "year"
    t.text     "summary"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "dimension_id"
  end

  create_table "raw_gundams", :force => true do |t|
    t.string   "url"
    t.string   "period"
    t.string   "name"
    t.string   "name_chs"
    t.string   "name_jp"
    t.string   "model"
    t.string   "usage"
    t.string   "force"
    t.string   "story"
    t.string   "manufactory"
    t.string   "specifications"
    t.string   "internal_environment"
    t.string   "measurement"
    t.string   "weight"
    t.string   "armor"
    t.string   "output"
    t.string   "propulsion"
    t.string   "acceleration"
    t.string   "special_equipped"
    t.string   "default_weapon"
    t.string   "selected_weapon"
    t.string   "hand_weapon"
    t.string   "ranged_weapon"
    t.text     "summary"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "stories", :force => true do |t|
    t.integer  "gundam_id"
    t.string   "name"
    t.text     "summary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "usages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
