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

ActiveRecord::Schema.define(:version => 20120816191645) do

  create_table "daily_metrics", :force => true do |t|
    t.integer "measureable_id"
    t.integer "day"
    t.integer "count",          :default => 0, :null => false
  end

  add_index "daily_metrics", ["measureable_id"], :name => "index_daily_metrics_on_measureable_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.integer  "measureable_id"
    t.datetime "timestamp"
    t.boolean  "processed"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "events", ["measureable_id"], :name => "index_events_on_measureable_id"

  create_table "hourly_metrics", :force => true do |t|
    t.integer "measureable_id"
    t.integer "hour"
    t.integer "count",          :default => 0, :null => false
  end

  add_index "hourly_metrics", ["measureable_id"], :name => "index_hourly_metrics_on_measureable_id"

  create_table "measureables", :force => true do |t|
    t.string   "service"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "monthly_metrics", :force => true do |t|
    t.integer "measureable_id"
    t.string  "month"
    t.integer "count"
  end

  add_index "monthly_metrics", ["measureable_id"], :name => "index_monthly_metrics_on_measureable_id"

  create_table "weekly_metrics", :force => true do |t|
    t.integer "measureable_id"
    t.integer "week"
    t.integer "count",          :default => 0, :null => false
  end

  add_index "weekly_metrics", ["measureable_id"], :name => "index_weekly_metrics_on_measureable_id"

end
