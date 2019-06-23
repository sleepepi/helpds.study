# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_23_212342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "position"
    t.integer "folders_count", default: 0, null: false
    t.boolean "archived", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["archived"], name: "index_categories_on_archived"
    t.index ["folders_count"], name: "index_categories_on_folders_count"
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["position"], name: "index_categories_on_position"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "folder_id"
    t.string "file"
    t.string "filename"
    t.string "content_type"
    t.bigint "byte_size", default: 0, null: false
    t.integer "download_count", default: 0, null: false
    t.boolean "featured", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["byte_size"], name: "index_documents_on_byte_size"
    t.index ["content_type"], name: "index_documents_on_content_type"
    t.index ["download_count"], name: "index_documents_on_download_count"
    t.index ["featured"], name: "index_documents_on_featured"
    t.index ["folder_id", "filename"], name: "index_documents_on_folder_id_and_filename", unique: true
  end

  create_table "folders", force: :cascade do |t|
    t.bigint "category_id"
    t.string "name"
    t.string "slug"
    t.text "description"
    t.integer "position"
    t.boolean "archived", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "documents_count", default: 0, null: false
    t.index ["archived"], name: "index_folders_on_archived"
    t.index ["category_id", "name"], name: "index_folders_on_category_id_and_name", unique: true
    t.index ["category_id", "slug"], name: "index_folders_on_category_id_and_slug", unique: true
    t.index ["position"], name: "index_folders_on_position"
  end

  create_table "page_reports", force: :cascade do |t|
    t.bigint "page_id"
    t.bigint "report_id"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_id", "report_id"], name: "index_page_reports_on_page_id_and_report_id", unique: true
    t.index ["position"], name: "index_page_reports_on_position"
  end

  create_table "pages", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "position"
    t.boolean "archived", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["archived"], name: "index_pages_on_archived"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "access_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "report_rows", force: :cascade do |t|
    t.bigint "report_id"
    t.string "label"
    t.text "expression"
    t.integer "position"
    t.jsonb "result"
    t.boolean "muted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["position"], name: "index_report_rows_on_position"
    t.index ["report_id"], name: "index_report_rows_on_report_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "project_id"
    t.string "name"
    t.string "header_label"
    t.jsonb "header"
    t.datetime "last_cached_at"
    t.boolean "archived", default: false, null: false
    t.boolean "sites_enabled", default: true, null: false
    t.string "report_type"
    t.text "filter_expression"
    t.text "group_expression"
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["archived"], name: "index_reports_on_archived"
    t.index ["project_id"], name: "index_reports_on_project_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "center_type"
    t.boolean "archived", default: false, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["archived"], name: "index_sites_on_archived"
    t.index ["center_type"], name: "index_sites_on_center_type"
    t.index ["deleted"], name: "index_sites_on_deleted"
    t.index ["name"], name: "index_sites_on_name", unique: true
    t.index ["slug"], name: "index_sites_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "full_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.boolean "approved", default: false, null: false
    t.boolean "admin", default: false, null: false
    t.boolean "editor", default: false, null: false
    t.boolean "unblinded", default: false, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "approval_sent_at"
    t.string "keywords"
    t.string "role"
    t.boolean "key_contact", default: false, null: false
    t.string "phone"
    t.bigint "site_id"
    t.string "profile_picture"
    t.index ["admin"], name: "index_users_on_admin"
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted"], name: "index_users_on_deleted"
    t.index ["editor"], name: "index_users_on_editor"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["site_id"], name: "index_users_on_site_id"
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "name"
    t.text "embed_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
