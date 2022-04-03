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

ActiveRecord::Schema.define(version: 2022_04_03_194015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "abouts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.string "heading_level", null: false
    t.text "content", null: false
    t.boolean "published", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "address_type"
    t.string "address_l1"
    t.string "address_l2"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "camp_application_pi_id"
    t.uuid "profile_id"
    t.string "zippostal"
    t.uuid "state_province_id"
    t.uuid "county_id"
    t.string "zip4code"
    t.index ["camp_application_pi_id"], name: "index_addresses_on_camp_application_pi_id"
    t.index ["county_id"], name: "index_addresses_on_county_id"
    t.index ["profile_id"], name: "index_addresses_on_profile_id"
    t.index ["state_province_id"], name: "index_addresses_on_state_province_id"
  end

  create_table "board_members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.text "bio"
    t.string "pronouns"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bylaw_article_sections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "sec_num"
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "bylaw_article_id", null: false
    t.index ["bylaw_article_id"], name: "index_bylaw_article_sections_on_bylaw_article_id"
  end

  create_table "bylaw_article_subsections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "subsec_num"
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "bylaw_article_section_id", null: false
    t.uuid "bylaw_article_id", null: false
    t.index ["bylaw_article_id"], name: "index_bylaw_article_subsections_on_bylaw_article_id"
    t.index ["bylaw_article_section_id"], name: "index_bylaw_article_subsections_on_bylaw_article_section_id"
  end

  create_table "bylaw_articles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "roman_numeral"
    t.string "title"
    t.text "introduction"
    t.uuid "bylaw_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bylaw_id"], name: "index_bylaw_articles_on_bylaw_id"
  end

  create_table "bylaws", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "introduction", null: false
    t.string "status", default: "Draft", null: false
    t.datetime "proposed", precision: 6
    t.datetime "approved", precision: 6
    t.boolean "current", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "camp_application_bis", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "about_you"
    t.text "past_camps"
    t.text "active_community"
    t.text "interests"
    t.text "other_comments"
    t.uuid "camp_application_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_id"], name: "index_camp_application_bis_on_camp_application_id"
  end

  create_table "camp_application_c3s", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.boolean "agree"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_id"], name: "index_camp_application_c3s_on_camp_application_id"
  end

  create_table "camp_application_ceus", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.text "certifications"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_id"], name: "index_camp_application_ceus_on_camp_application_id"
  end

  create_table "camp_application_covids", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.boolean "vaccinated"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "vaccination_type"
    t.date "first_shot"
    t.date "second_shot"
    t.date "booster_shot"
    t.index ["camp_application_id"], name: "index_camp_application_covids_on_camp_application_id"
  end

  create_table "camp_application_emergencies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.string "contact_full_name"
    t.string "contact_relationship"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_id"], name: "index_camp_application_emergencies_on_camp_application_id"
  end

  create_table "camp_application_incs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.text "identity"
    t.text "communication_pref"
    t.text "receiv_signs"
    t.text "dominant_hand"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_id"], name: "index_camp_application_incs_on_camp_application_id"
  end

  create_table "camp_application_lodgings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.boolean "on_premises"
    t.boolean "share_smoker"
    t.boolean "difficulty_walking"
    t.boolean "difficulty_stairs"
    t.boolean "service_animal"
    t.boolean "share_service_animal"
    t.text "mobility_aids"
    t.boolean "medical_device_charging"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_id"], name: "index_camp_application_lodgings_on_camp_application_id"
  end

  create_table "camp_application_matchings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.text "work_with_type"
    t.string "height"
    t.string "describe_self"
    t.text "activity_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_id"], name: "index_camp_application_matchings_on_camp_application_id"
  end

  create_table "camp_application_matchnps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_matching_id", null: false
    t.string "name_type"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_matching_id"], name: "index_camp_application_matchnps_on_camp_application_matching_id"
  end

  create_table "camp_application_meals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.string "dietary_lifestyle"
    t.text "allergens"
    t.text "dietary_restrictions"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_id"], name: "index_camp_application_meals_on_camp_application_id"
  end

  create_table "camp_application_medicals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.boolean "medical_policy"
    t.boolean "bring_assistant"
    t.boolean "smoke"
    t.text "medical_conditions"
    t.text "other_health"
    t.text "medical_allergies"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_id"], name: "index_camp_application_medicals_on_camp_application_id"
  end

  create_table "camp_application_permissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.boolean "agree"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_id"], name: "index_camp_application_permissions_on_camp_application_id"
  end

  create_table "camp_application_pis", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "gender"
    t.text "pronouns"
    t.date "dob"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_id"], name: "index_camp_application_pis_on_camp_application_id"
  end

  create_table "camp_application_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "kind"
    t.text "description"
    t.uuid "camp_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_id"], name: "index_camp_application_types_on_camp_id"
  end

  create_table "camp_applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_id", null: false
    t.uuid "user_id", null: false
    t.string "status", default: "New Application -- In Progress", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "camp_application_type_id"
    t.index ["camp_application_type_id"], name: "index_camp_applications_on_camp_application_type_id"
    t.index ["camp_id"], name: "index_camp_applications_on_camp_id"
    t.index ["user_id"], name: "index_camp_applications_on_user_id"
  end

  create_table "camps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.datetime "start", precision: 6
    t.datetime "end", precision: 6
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "counties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "state_province_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_province_id"], name: "index_counties_on_state_province_id"
  end

  create_table "countries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "unicode_flag"
    t.string "country_code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "event_attendees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_attendees_on_event_id", unique: true
    t.index ["user_id"], name: "index_event_attendees_on_user_id", unique: true
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start_time", precision: 6
    t.datetime "end_time", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "has_virtual_space", default: false, null: false
    t.boolean "in_person", default: false, null: false
    t.boolean "registration_required", default: false, null: false
  end

  create_table "phone_numbers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "camp_application_pi_id"
    t.string "phone_type"
    t.string "phone_number"
    t.text "service_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["camp_application_pi_id"], name: "index_phone_numbers_on_camp_application_pi_id"
    t.index ["user_id"], name: "index_phone_numbers_on_user_id"
  end

  create_table "policies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.boolean "copy_protect"
    t.boolean "published"
    t.datetime "published_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "gender_string"
    t.string "pronouns"
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "social_networks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "icon_class"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "state_provinces", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "unicode_flag"
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "country_id", null: false
    t.index ["country_id"], name: "index_state_provinces_on_country_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: 6
    t.datetime "last_sign_in_at", precision: 6
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: 6
    t.datetime "confirmation_sent_at", precision: 6
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_salt"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "virtual_spaces", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_virtual_spaces_on_event_id"
  end

  create_table "zoom_meetings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "topic"
    t.uuid "virtual_space_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "room_type"
    t.string "meeting_id"
    t.text "start_url"
    t.text "join_url"
    t.index ["virtual_space_id"], name: "index_zoom_meetings_on_virtual_space_id"
  end

  add_foreign_key "addresses", "camp_application_pis"
  add_foreign_key "addresses", "counties"
  add_foreign_key "addresses", "profiles"
  add_foreign_key "addresses", "state_provinces"
  add_foreign_key "bylaw_article_sections", "bylaw_articles"
  add_foreign_key "bylaw_article_subsections", "bylaw_article_sections"
  add_foreign_key "bylaw_article_subsections", "bylaw_articles"
  add_foreign_key "bylaw_articles", "bylaws"
  add_foreign_key "camp_application_bis", "camp_applications"
  add_foreign_key "camp_application_c3s", "camp_applications"
  add_foreign_key "camp_application_ceus", "camp_applications"
  add_foreign_key "camp_application_covids", "camp_applications"
  add_foreign_key "camp_application_emergencies", "camp_applications"
  add_foreign_key "camp_application_incs", "camp_applications"
  add_foreign_key "camp_application_lodgings", "camp_applications"
  add_foreign_key "camp_application_matchings", "camp_applications"
  add_foreign_key "camp_application_matchnps", "camp_application_matchings"
  add_foreign_key "camp_application_meals", "camp_applications"
  add_foreign_key "camp_application_medicals", "camp_applications"
  add_foreign_key "camp_application_permissions", "camp_applications"
  add_foreign_key "camp_application_pis", "camp_applications"
  add_foreign_key "camp_application_types", "camps"
  add_foreign_key "camp_applications", "camp_application_types"
  add_foreign_key "camp_applications", "camps"
  add_foreign_key "camp_applications", "users"
  add_foreign_key "counties", "state_provinces"
  add_foreign_key "event_attendees", "events"
  add_foreign_key "event_attendees", "users"
  add_foreign_key "phone_numbers", "camp_application_pis"
  add_foreign_key "phone_numbers", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "state_provinces", "countries"
  add_foreign_key "virtual_spaces", "events"
  add_foreign_key "zoom_meetings", "virtual_spaces"
end
