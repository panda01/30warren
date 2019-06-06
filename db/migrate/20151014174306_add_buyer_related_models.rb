class AddBuyerRelatedModels < ActiveRecord::Migration
  def change
    create_table "amenities", force: :cascade do |t|
      t.text     "caption",    limit: 65535
      t.datetime "created_at",                              null: false
      t.datetime "updated_at",                              null: false
      t.boolean  "active",     limit: 1,     default: true
      t.integer  "position",   limit: 4
    end

    create_table "local_features", force: :cascade do |t|
      t.text     "caption",    limit: 65535
      t.boolean  "active",     limit: 1,     default: true
      t.datetime "created_at",                              null: false
      t.datetime "updated_at",                              null: false
      t.integer  "position",   limit: 4
    end

    create_table "sales_agents", force: :cascade do |t|
      t.string   "name",          limit: 255
      t.string   "phone_number",  limit: 255
      t.string   "email_address", limit: 255
      t.datetime "created_at",                               null: false
      t.datetime "updated_at",                               null: false
      t.boolean  "active",        limit: 1,   default: true
    end

    create_table "unit_types", force: :cascade do |t|
      t.string   "name",                   limit: 255
      t.text     "description",            limit: 65535
      t.integer  "number_of_bedrooms",     limit: 4
      t.integer  "number_of_bathrooms",    limit: 4
      t.integer  "interior_square_feet",   limit: 4
      t.integer  "exterior_square_feet",   limit: 4
      t.integer  "interior_square_meters", limit: 4
      t.integer  "exterior_square_meters", limit: 4
      t.integer  "number_of_powder_rooms", limit: 4
      t.boolean  "has_terace",             limit: 1,     default: false
      t.datetime "created_at",                                           null: false
      t.datetime "updated_at",                                           null: false
      t.boolean  "penthouse",              limit: 1,     default: false
    end

    create_table "units", force: :cascade do |t|
      t.integer  "floor",                  limit: 4
      t.string   "letter",                 limit: 255
      t.string   "name",                   limit: 255
      t.integer  "number_of_bedrooms",     limit: 4
      t.integer  "number_of_bathrooms",    limit: 4
      t.integer  "price",                  limit: 4
      t.integer  "interior_square_feet",   limit: 4
      t.integer  "exterior_square_feet",   limit: 4
      t.string   "status",                 limit: 255
      t.boolean  "active",                 limit: 1,   default: true
      t.datetime "created_at",                                         null: false
      t.datetime "updated_at",                                         null: false
      t.integer  "interior_square_meters", limit: 4
      t.integer  "exterior_square_meters", limit: 4
      t.integer  "number_of_powder_rooms", limit: 4
      t.boolean  "has_terace",             limit: 1,   default: false
      t.integer  "unit_type_id",           limit: 4
    end

  end
end
