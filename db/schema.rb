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

ActiveRecord::Schema.define(version: 20170214013419) do

  create_table "affected_hosts", force: :cascade do |t|
    t.string   "host_ip"
    t.string   "host_fqdn"
    t.string   "netbios_name"
    t.string   "mac_address"
    t.string   "platform"
    t.string   "operating_system"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "source_file_id"
    t.index ["source_file_id"], name: "index_affected_hosts_on_source_file_id"
  end

  create_table "monitored_items", force: :cascade do |t|
    t.integer  "project_group_id"
    t.integer  "source_file_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["project_group_id"], name: "index_monitored_items_on_project_group_id"
    t.index ["source_file_id"], name: "index_monitored_items_on_source_file_id"
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
    t.index ["vulnerability_id"], name: "index_remedy_actions_on_vulnerability_id"
  end

  create_table "source_files", force: :cascade do |t|
    t.string   "title"
    t.binary   "data"
    t.string   "filename"
    t.string   "mime_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vulnerabilities", force: :cascade do |t|
    t.integer  "port"
    t.string   "service_name"
    t.string   "protocol"
    t.integer  "severity"
    t.integer  "plugin_id"
    t.string   "vulnerability_name"
    t.string   "plugin_family"
    t.string   "cve"
    t.integer  "cvss_score"
    t.string   "cpe"
    t.datetime "vulnerability_date"
    t.datetime "patch_date"
    t.boolean  "exploit_available"
    t.text     "description"
    t.text     "synopsis"
    t.text     "solution"
    t.text     "output"
    t.datetime "last_seen"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "affected_host_id"
    t.index ["affected_host_id"], name: "index_vulnerabilities_on_affected_host_id"
  end

end
