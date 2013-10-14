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

ActiveRecord::Schema.define(:version => 20131007143520) do

  create_table "about_sections", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "section"
    t.boolean  "active",            :default => true
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "col_number"
  end

  create_table "answers", :force => true do |t|
    t.text     "content"
    t.integer  "question_id"
    t.integer  "votes",       :default => 0
    t.boolean  "accepted",    :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "attachments", :force => true do |t|
    t.string   "note"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "attached_file_file_name"
    t.string   "attached_file_content_type"
    t.integer  "attached_file_file_size"
    t.datetime "attached_file_updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "organization"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "contents", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.boolean  "published",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "events", :force => true do |t|
    t.datetime "event_date"
    t.string   "event_name"
    t.text     "event_description"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "location"
    t.datetime "event_end"
    t.boolean  "in_footer",         :default => false
  end

  create_table "judges", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "organization"
    t.string   "sector"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "mentors", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "organization"
    t.string   "sector"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "section"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "answered",   :default => false
    t.integer  "votes",      :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "row_order"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "group_name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
    t.string   "google_access_token"
    t.string   "google_refresh_token"
    t.datetime "google_expires_at"
    t.string   "label"
    t.string   "team"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
