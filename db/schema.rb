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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180209214516) do

  create_table "amenities", force: :cascade do |t|
    t.text     "caption",    limit: 65535
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "active",                   default: true
    t.integer  "position",   limit: 4
    t.string   "title",      limit: 255
  end

  create_table "anchor_blocks", force: :cascade do |t|
    t.string  "title",            limit: 255
    t.integer "content_block_id", limit: 4
    t.boolean "visible",                        default: false
    t.text    "body",             limit: 65535
  end

  add_index "anchor_blocks", ["content_block_id"], name: "index_anchor_blocks_on_content_block_id", using: :btree

  create_table "buyers", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "email",      limit: 255
    t.string   "slug",       limit: 255
    t.text     "data",       limit: 65535
    t.text     "message",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "helped_by",  limit: 255
  end

  create_table "buyers_units", id: false, force: :cascade do |t|
    t.integer "buyer_id", limit: 4, null: false
    t.integer "unit_id",  limit: 4, null: false
  end

  add_index "buyers_units", ["buyer_id", "unit_id"], name: "index_buyers_units_on_buyer_id_and_unit_id", using: :btree
  add_index "buyers_units", ["unit_id", "buyer_id"], name: "index_buyers_units_on_unit_id_and_buyer_id", using: :btree

  create_table "content_blocks", force: :cascade do |t|
    t.integer  "parent_id",   limit: 4
    t.string   "parent_type", limit: 255
    t.string   "block_type",  limit: 255
    t.integer  "position",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_blocks", ["parent_type", "parent_id", "block_type"], name: "index_content_blocks_on_many_fields", using: :btree

  create_table "feature_blocks", force: :cascade do |t|
    t.string  "title",            limit: 255
    t.integer "content_block_id", limit: 4
    t.text    "body",             limit: 65535
    t.text    "features",         limit: 65535
    t.string  "width",            limit: 255
    t.string  "subhead",          limit: 255,   default: "Features"
  end

  add_index "feature_blocks", ["content_block_id"], name: "index_feature_blocks_on_content_block_id", using: :btree

  create_table "file_blocks", force: :cascade do |t|
    t.string  "title",            limit: 255,   null: false
    t.string  "subtitle",         limit: 255,   null: false
    t.integer "content_block_id", limit: 4
    t.text    "body",             limit: 65535
    t.string  "file",             limit: 255
    t.string  "link_text",        limit: 255
  end

  add_index "file_blocks", ["content_block_id"], name: "index_file_blocks_on_content_block_id", using: :btree

  create_table "image_blocks", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "caption",          limit: 65535
    t.integer  "content_block_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "size",             limit: 255,   default: "full", null: false
    t.string   "treatment",        limit: 255
    t.string   "height_style",     limit: 255
    t.boolean  "enlargeable",                    default: true
    t.boolean  "rendering",                      default: false
  end

  add_index "image_blocks", ["content_block_id"], name: "index_image_blocks_on_content_block_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "attachment",        limit: 255
    t.integer  "parent_id",         limit: 4
    t.string   "parent_type",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "relationship_name", limit: 255
    t.text     "caption",           limit: 65535
    t.integer  "position",          limit: 4
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.string   "content_type",      limit: 255
  end

  add_index "images", ["parent_id", "parent_type"], name: "index_images_on_parent_id_and_parent_type", using: :btree

  create_table "local_features", force: :cascade do |t|
    t.text     "caption",    limit: 65535
    t.boolean  "active",                   default: true
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "position",   limit: 4
    t.string   "title",      limit: 255
  end

  create_table "map_blocks", force: :cascade do |t|
    t.integer  "content_block_id", limit: 4
    t.string   "title",            limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "slug",           limit: 255
    t.integer  "position",       limit: 4
    t.boolean  "editable"
    t.boolean  "in_primary_nav"
    t.boolean  "active",                     default: true
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "panorama_blocks", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.string   "caption",          limit: 255
    t.integer  "content_block_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "places", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "zip",        limit: 255
    t.string   "category",   limit: 255
    t.string   "long",       limit: 255
    t.string   "lat",        limit: 255
    t.string   "slug",       limit: 255
    t.boolean  "active",                   default: true
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.text     "aliases",    limit: 65535
  end

  create_table "press_clippings", force: :cascade do |t|
    t.text     "blurb",      limit: 65535
    t.string   "source",     limit: 255
    t.text     "url",        limit: 65535
    t.boolean  "active",                   default: true
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.date     "date"
    t.string   "title",      limit: 255
  end

  create_table "registrants", force: :cascade do |t|
    t.string   "email",            limit: 255
    t.string   "phone",            limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "price_range",      limit: 255
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
    t.string   "zip_code",         limit: 255
    t.string   "referral_channel", limit: 255
    t.string   "residence_type",   limit: 255
  end

  create_table "sales_agents", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "phone_number",  limit: 255
    t.string   "email_address", limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "active",                    default: true
  end

  create_table "slides", force: :cascade do |t|
    t.integer  "slideshow_block_id", limit: 4
    t.string   "slide_type",         limit: 255
    t.text     "caption",            limit: 65535
    t.integer  "position",           limit: 4
    t.text     "video_id",           limit: 65535
    t.text     "video_url",          limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slideshow_blocks", force: :cascade do |t|
    t.integer  "content_block_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_panorama",                default: false
    t.boolean  "contained"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "team_blocks", force: :cascade do |t|
    t.string  "title",            limit: 255,   null: false
    t.string  "subtitle",         limit: 255,   null: false
    t.integer "content_block_id", limit: 4
    t.text    "body",             limit: 65535
  end

  add_index "team_blocks", ["content_block_id"], name: "index_team_blocks_on_content_block_id", using: :btree

  create_table "team_members", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.boolean  "active",                    default: true
    t.integer  "position",    limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "role",        limit: 255
    t.string   "url",         limit: 255
  end

  create_table "text_blocks", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.integer  "content_block_id", limit: 4
    t.text     "body",             limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "text_blocks", ["content_block_id"], name: "index_text_blocks_on_content_block_id", using: :btree

  create_table "unit_types", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.text     "description",            limit: 65535
    t.integer  "number_of_bedrooms",     limit: 4,                             default: 0
    t.decimal  "number_of_bathrooms",                  precision: 2, scale: 1, default: 0.0
    t.integer  "interior_square_feet",   limit: 4
    t.integer  "exterior_square_feet",   limit: 4
    t.integer  "interior_square_meters", limit: 4
    t.integer  "exterior_square_meters", limit: 4
    t.integer  "number_of_powder_rooms", limit: 4,                             default: 0
    t.datetime "created_at",                                                                   null: false
    t.datetime "updated_at",                                                                   null: false
    t.boolean  "penthouse",                                                    default: false
    t.boolean  "duplex",                                                       default: false
  end

  create_table "units", force: :cascade do |t|
    t.integer  "floor",                  limit: 4
    t.string   "letter",                 limit: 255
    t.string   "name",                   limit: 255
    t.integer  "number_of_bedrooms",     limit: 4
    t.decimal  "number_of_bathrooms",                precision: 2, scale: 1, default: 0.0
    t.integer  "price",                  limit: 4
    t.integer  "interior_square_feet",   limit: 4
    t.integer  "exterior_square_feet",   limit: 4
    t.string   "status",                 limit: 255
    t.boolean  "active",                                                     default: true
    t.datetime "created_at",                                                                 null: false
    t.datetime "updated_at",                                                                 null: false
    t.integer  "interior_square_meters", limit: 4
    t.integer  "exterior_square_meters", limit: 4
    t.integer  "number_of_powder_rooms", limit: 4
    t.integer  "unit_type_id",           limit: 4
    t.string   "exposure",               limit: 255
    t.integer  "monthly_charges",        limit: 4
    t.integer  "monthly_taxes",          limit: 4
    t.boolean  "premium",                                                    default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "username",        limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.boolean  "is_admin",                    default: false
    t.boolean  "is_sysop",                    default: false
    t.boolean  "active",                      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "video_blocks", force: :cascade do |t|
    t.text     "url",              limit: 65535
    t.text     "video_id",         limit: 65535
    t.string   "title",            limit: 255
    t.text     "caption",          limit: 65535
    t.integer  "content_block_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "views", force: :cascade do |t|
    t.text    "caption",  limit: 65535
    t.boolean "active",                 default: true
    t.integer "position", limit: 4
    t.string  "title",    limit: 255
  end

end
