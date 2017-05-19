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

ActiveRecord::Schema.define(version: 20170406150325) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "affected_hosts", force: :cascade do |t|
    t.string   "host_ip"
    t.string   "host_fqdn"
    t.string   "netbios_name"
    t.string   "mac_address"
    t.string   "cpe"
    t.string   "platform"
    t.string   "operating_system"
    t.string   "system_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "source_file_id"
    t.index ["source_file_id"], name: "index_affected_hosts_on_source_file_id", using: :btree
  end

  create_table "monitored_items", force: :cascade do |t|
    t.integer  "project_group_id"
    t.integer  "source_file_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["project_group_id"], name: "index_monitored_items_on_project_group_id", using: :btree
    t.index ["source_file_id"], name: "index_monitored_items_on_source_file_id", using: :btree
  end

  create_table "project_groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "remedy_actions", force: :cascade do |t|
    t.integer  "status",           default: 1
    t.string   "assigned_to"
    t.text     "remarks"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "vulnerability_id"
    t.index ["vulnerability_id"], name: "index_remedy_actions_on_vulnerability_id", using: :btree
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "project_group_id"
    t.integer  "affected_host_id"
    t.index ["affected_host_id"], name: "index_reports_on_affected_host_id", using: :btree
    t.index ["project_group_id"], name: "index_reports_on_project_group_id", using: :btree
  end

  create_table "source_files", force: :cascade do |t|
    t.string   "title"
    t.binary   "data"
    t.string   "filename"
    t.string   "mime_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "vulnerabilities", force: :cascade do |t|
    t.string   "affected_url"
    t.integer  "port"
    t.string   "service_name"
    t.string   "protocol"
    t.integer  "severity"
    t.integer  "plugin_id"
    t.string   "name"
    t.string   "plugin_family"
    t.string   "plugin_name"
    t.string   "cpe"
    t.string   "cve"
    t.string   "cwe"
    t.float    "cvss_score"
    t.datetime "publish_date"
    t.datetime "patch_date"
    t.boolean  "exploit_available", default: false
    t.boolean  "exploitable",       default: false
    t.string   "plugin_type"
    t.text     "description"
    t.text     "synopsis"
    t.text     "solution"
    t.text     "request"
    t.text     "response"
    t.string   "parameter"
    t.string   "xref"
    t.string   "cert"
    t.text     "see_also"
    t.text     "comment"
    t.text     "category"
    t.boolean  "enable",            default: true
    t.datetime "last_seen"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "affected_host_id"
    t.index ["affected_host_id"], name: "index_vulnerabilities_on_affected_host_id", using: :btree
  end

  add_foreign_key "affected_hosts", "source_files"
  add_foreign_key "remedy_actions", "vulnerabilities"
  add_foreign_key "reports", "affected_hosts"
  add_foreign_key "reports", "project_groups"
  add_foreign_key "vulnerabilities", "affected_hosts"
end
