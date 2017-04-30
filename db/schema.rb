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

ActiveRecord::Schema.define(version: 20170429134537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "vyrobni_linka_polozkas", force: :cascade do |t|
    t.integer  "vyrobni_linka_id"
    t.date     "datum"
    t.integer  "dobre_kusy"
    t.integer  "nok_ftf"
    t.integer  "ok_ftf"
    t.integer  "nok_rq"
    t.float    "rq"
    t.float    "rq_cil"
    t.float    "zm_rq"
    t.float    "ftf"
    t.integer  "ftf_cil"
    t.integer  "zm_ftf"
    t.integer  "zmetky"
    t.integer  "opakovany_test"
    t.integer  "rework"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["vyrobni_linka_id"], name: "index_vyrobni_linka_polozkas_on_vyrobni_linka_id", using: :btree
  end

  create_table "vyrobni_linka_qualitar_polozkas", force: :cascade do |t|
    t.integer  "vyrobni_linka_id"
    t.integer  "external_record"
    t.integer  "poradi_id"
    t.date     "datum"
    t.time     "cas"
    t.string   "zakazka"
    t.string   "typ"
    t.string   "v_cislo"
    t.string   "pripojka"
    t.string   "otvor"
    t.string   "delka_sroubu"
    t.string   "testnost"
    t.string   "prachovka"
    t.boolean  "lisovani_nok"
    t.string   "otvor1"
    t.string   "otvor2"
    t.string   "otvor3"
    t.string   "otvor4"
    t.string   "otvor5"
    t.string   "otvor6"
    t.string   "zatka1"
    t.string   "zatka2"
    t.string   "zatka3"
    t.string   "zatka4"
    t.string   "zatka5"
    t.string   "zatka6"
    t.string   "vyska_tlac_t"
    t.string   "vyska_pist_t"
    t.boolean  "pist_nok"
    t.boolean  "tlac_nok"
    t.string   "vyska_tlac"
    t.string   "d_limit_s"
    t.string   "d_limit_f"
    t.string   "h_limit_s"
    t.string   "h_limit_f"
    t.string   "s1"
    t.string   "f1"
    t.string   "s2"
    t.string   "f2"
    t.string   "s3"
    t.string   "f3"
    t.string   "s4"
    t.string   "f4"
    t.string   "s5"
    t.string   "f5"
    t.float    "tesnost_pr"
    t.float    "tesnost_bar"
    t.time     "cas_testu"
    t.string   "vysledek"
    t.string   "poradi_ks"
    t.string   "cislo_tlac"
    t.string   "obsluha"
    t.string   "index_pracovnika"
    t.string   "paleta"
    t.string   "tester"
    t.string   "cisteni"
    t.string   "prujezdy"
    t.string   "odsroubovani"
    t.string   "plech_app"
    t.string   "tlak_sila"
    t.string   "tlak_tes"
    t.string   "moment_bocni"
    t.string   "moment_celni"
    t.string   "kod_chyby"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["vyrobni_linka_id"], name: "index_vyrobni_linka_qualitar_polozkas_on_vyrobni_linka_id", using: :btree
  end

  create_table "vyrobni_linkas", force: :cascade do |t|
    t.string   "nazev"
    t.integer  "maximum_chyb"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
