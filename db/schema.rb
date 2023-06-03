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

ActiveRecord::Schema[7.0].define(version: 2023_06_03_003244) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "abouts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.string "heading_level", null: false
    t.text "content", null: false
    t.boolean "published", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "address_type"
    t.string "address_l1"
    t.string "address_l2"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "state_province_id", null: false
    t.uuid "camp_application_pi_id"
    t.uuid "profile_id"
    t.string "zippostal"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bylaw_article_sections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "sec_num"
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "bylaw_article_id", null: false
    t.index ["bylaw_article_id"], name: "index_bylaw_article_sections_on_bylaw_article_id"
  end

  create_table "bylaw_article_subsections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "subsec_num"
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bylaw_id"], name: "index_bylaw_articles_on_bylaw_id"
  end

  create_table "bylaws", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "introduction", null: false
    t.string "status", default: "Draft", null: false
    t.datetime "proposed"
    t.datetime "approved"
    t.boolean "current", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "camp_application_bis", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "about_you"
    t.text "past_camps"
    t.text "active_community"
    t.text "interests"
    t.text "other_comments"
    t.uuid "camp_application_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_id"], name: "index_camp_application_bis_on_camp_application_id"
  end

  create_table "camp_application_c3s", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.boolean "agree"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_id"], name: "index_camp_application_c3s_on_camp_application_id"
  end

  create_table "camp_application_cas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "sign_language"
    t.string "tactile"
    t.string "pt"
    t.uuid "camp_application_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_id"], name: "index_camp_application_cas_on_camp_application_id"
  end

  create_table "camp_application_ceus", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.text "certifications"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_id"], name: "index_camp_application_ceus_on_camp_application_id"
  end

  create_table "camp_application_commitments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.boolean "commit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_id"], name: "index_camp_application_commitments_on_camp_application_id"
  end

  create_table "camp_application_covids", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.boolean "vaccinated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_id"], name: "index_camp_application_emergencies_on_camp_application_id"
  end

  create_table "camp_application_incs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.text "identity"
    t.text "communication_pref"
    t.text "receiv_signs"
    t.text "dominant_hand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tent_or_cabin"
    t.boolean "bring_tent"
    t.text "share_with"
    t.index ["camp_application_id"], name: "index_camp_application_lodgings_on_camp_application_id"
  end

  create_table "camp_application_matchings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.text "work_with_type"
    t.string "height"
    t.string "describe_self"
    t.text "activity_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_id"], name: "index_camp_application_matchings_on_camp_application_id"
  end

  create_table "camp_application_matchnps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_matching_id", null: false
    t.string "name_type"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_matching_id"], name: "index_camp_application_matchnps_on_camp_application_matching_id"
  end

  create_table "camp_application_meals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.string "dietary_lifestyle"
    t.text "allergens"
    t.text "dietary_restrictions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_id"], name: "index_camp_application_medicals_on_camp_application_id"
  end

  create_table "camp_application_permissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.boolean "agree"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_id"], name: "index_camp_application_permissions_on_camp_application_id"
  end

  create_table "camp_application_pis", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_application_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "gender"
    t.text "pronouns"
    t.date "dob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_id"], name: "index_camp_application_pis_on_camp_application_id"
  end

  create_table "camp_application_shifts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "shifts"
    t.uuid "camp_application_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_id"], name: "index_camp_application_shifts_on_camp_application_id"
  end

  create_table "camp_application_trainings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "available"
    t.text "training_history"
    t.uuid "camp_application_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_id"], name: "index_camp_application_trainings_on_camp_application_id"
  end

  create_table "camp_application_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "kind"
    t.text "description"
    t.uuid "camp_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost"
    t.index ["camp_id"], name: "index_camp_application_types_on_camp_id"
  end

  create_table "camp_applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "camp_id", null: false
    t.uuid "user_id", null: false
    t.string "status", default: "New Application -- In Progress", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "camp_application_type_id"
    t.index ["camp_application_type_id"], name: "index_camp_applications_on_camp_application_type_id"
    t.index ["camp_id"], name: "index_camp_applications_on_camp_id"
    t.index ["user_id"], name: "index_camp_applications_on_user_id"
  end

  create_table "camps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.datetime "start"
    t.datetime "end"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "challenge_milestones", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "milestone_type"
    t.string "name"
    t.integer "goal"
    t.string "goal_unit"
    t.string "prize"
    t.uuid "challenge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hidden"
    t.text "description"
    t.index ["challenge_id"], name: "index_challenge_milestones_on_challenge_id"
  end

  create_table "challenge_participants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "challenge_id", null: false
    t.uuid "user_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "shirt_size"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "price_id"
    t.boolean "paid"
    t.index ["challenge_id"], name: "index_challenge_participants_on_challenge_id"
    t.index ["price_id"], name: "index_challenge_participants_on_price_id"
    t.index ["user_id"], name: "index_challenge_participants_on_user_id"
  end

  create_table "challenges", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.datetime "start"
    t.datetime "end"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.integer "challenge_type"
  end

  create_table "channel_menu_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "channel_menu_id", null: false
    t.integer "position"
    t.string "name"
    t.string "icon_class"
    t.string "external_url"
    t.string "path"
    t.boolean "open_tab"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_menu_id"], name: "index_channel_menu_items_on_channel_menu_id"
  end

  create_table "channel_menus", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "location"
    t.uuid "channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channel_menus_on_channel_id"
  end

  create_table "channels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "subdomain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "domain_host"
    t.string "navbar_bg"
    t.string "navbar_bg_invert"
    t.string "brand_bg"
    t.string "brand_bg_invert"
    t.index ["subdomain_id"], name: "index_channels_on_subdomain_id"
  end

  create_table "counties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "state_province_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_province_id"], name: "index_counties_on_state_province_id"
  end

  create_table "countries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "unicode_flag"
    t.string "country_code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cue_blocks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "text_track_id", null: false
    t.integer "cue_num"
    t.integer "cue_type"
    t.string "cue_comment"
    t.time "start"
    t.time "end"
    t.text "payload"
    t.boolean "sdh"
    t.integer "vertical", default: 0, null: false
    t.integer "line"
    t.integer "line_type"
    t.integer "position"
    t.integer "size"
    t.integer "align"
    t.string "url"
    t.string "link_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "synthesize_text"
    t.text "ssml"
    t.index ["text_track_id"], name: "index_cue_blocks_on_text_track_id"
  end

  create_table "departments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "program"
    t.string "amount"
    t.string "name"
    t.string "email"
    t.boolean "paid"
    t.string "zip"
    t.text "thank_you_note"
    t.datetime "tyn_sent_at"
    t.uuid "user_id"
    t.uuid "challenge_participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "amount_deci"
    t.index ["challenge_participant_id"], name: "index_donations_on_challenge_participant_id"
    t.index ["user_id"], name: "index_donations_on_user_id"
  end

  create_table "event_attendees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_attendees_on_event_id", unique: true
    t.index ["user_id"], name: "index_event_attendees_on_user_id", unique: true
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_virtual_space", default: false, null: false
    t.boolean "in_person", default: false, null: false
    t.boolean "registration_required", default: false, null: false
  end

  create_table "exercise_trackers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "challenge_participant_id", null: false
    t.string "activity"
    t.time "time"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "distance"
    t.integer "distance_unit", default: 0, null: false
    t.index ["challenge_participant_id"], name: "index_exercise_trackers_on_challenge_participant_id"
  end

  create_table "frequently_asked_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "challenge_id", null: false
    t.string "question_group"
    t.string "question"
    t.text "answer"
    t.integer "question_number"
    t.integer "group_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_frequently_asked_questions_on_challenge_id"
  end

  create_table "languages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "dialect"
    t.boolean "text"
    t.boolean "spoken"
    t.boolean "signed"
    t.string "short_code"
    t.string "long_code"
    t.bigint "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "index_languages_on_video_id"
  end

  create_table "participant_milestones", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "challenge_participant_id", null: false
    t.uuid "challenge_milestone_id", null: false
    t.datetime "earned_milestone_sent_at"
    t.boolean "accept_prize"
    t.boolean "shipped"
    t.string "shipping_tracking"
    t.datetime "shipped_notification_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_milestone_id"], name: "index_participant_milestones_on_challenge_milestone_id"
    t.index ["challenge_participant_id"], name: "index_participant_milestones_on_challenge_participant_id"
  end

  create_table "phone_numbers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "camp_application_pi_id"
    t.uuid "camp_application_emergency_id"
    t.string "phone_type"
    t.string "phone_number"
    t.text "service_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_application_emergency_id"], name: "index_phone_numbers_on_camp_application_emergency_id"
    t.index ["camp_application_pi_id"], name: "index_phone_numbers_on_camp_application_pi_id"
    t.index ["user_id"], name: "index_phone_numbers_on_user_id"
  end

  create_table "photos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "label"
    t.string "image_type"
    t.string "alt_text"
    t.text "description"
    t.uuid "product_image_set_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "exif"
    t.uuid "challenge_id"
    t.uuid "challenge_participant_id"
    t.uuid "challenge_milestone_id"
    t.uuid "exercise_tracker_id"
    t.index ["challenge_id"], name: "index_photos_on_challenge_id"
    t.index ["challenge_milestone_id"], name: "index_photos_on_challenge_milestone_id"
    t.index ["challenge_participant_id"], name: "index_photos_on_challenge_participant_id"
    t.index ["exercise_tracker_id"], name: "index_photos_on_exercise_tracker_id"
    t.index ["product_image_set_id"], name: "index_photos_on_product_image_set_id"
  end

  create_table "playlists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "sort_by"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "policies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.boolean "copy_protect"
    t.boolean "published"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "portfolios", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_portfolios_on_channel_id"
  end

  create_table "prices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "price"
    t.text "perks"
    t.boolean "shirt"
    t.text "shirt_description"
    t.uuid "challenge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_prices_on_challenge_id"
  end

  create_table "product_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.uuid "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_product_categories_on_department_id"
  end

  create_table "product_image_sets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.string "label"
    t.boolean "default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_image_sets_on_product_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.uuid "product_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
  end

  create_table "profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "gender_string"
    t.string "pronouns"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "question_options", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "survey_question_id", null: false
    t.string "name"
    t.integer "logic"
    t.text "sub_logic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rating_value"
    t.index ["survey_question_id"], name: "index_question_options_on_survey_question_id"
  end

  create_table "question_options_response_answers", id: false, force: :cascade do |t|
    t.uuid "question_option_id"
    t.uuid "response_answer_id"
    t.index ["question_option_id"], name: "index_question_options_response_answers_on_question_option_id"
    t.index ["response_answer_id"], name: "index_question_options_response_answers_on_response_answer_id"
  end

  create_table "response_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "survey_response_id", null: false
    t.uuid "survey_question_id", null: false
    t.text "long_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_question_id"], name: "index_response_answers_on_survey_question_id"
    t.index ["survey_response_id"], name: "index_response_answers_on_survey_response_id"
  end

  create_table "social_networks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "icon_class"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "channel_id"
    t.index ["channel_id"], name: "index_social_networks_on_channel_id"
  end

  create_table "sponsors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "state_provinces", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "unicode_flag"
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "country_id", null: false
    t.index ["country_id"], name: "index_state_provinces_on_country_id"
  end

  create_table "subdomains", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "survey_section_id", null: false
    t.integer "position"
    t.integer "question_type"
    t.string "title"
    t.text "description"
    t.boolean "requiret"
    t.boolean "conditionally_hidden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_section_id"], name: "index_survey_questions_on_survey_section_id"
  end

  create_table "survey_responses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "survey_id", null: false
    t.uuid "user_id"
    t.float "score"
    t.boolean "informed_consent"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email_address"
    t.text "include_sections"
    t.index ["survey_id"], name: "index_survey_responses_on_survey_id"
    t.index ["user_id"], name: "index_survey_responses_on_user_id"
  end

  create_table "survey_sections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "section_number"
    t.uuid "survey_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "conditionally_hidden"
    t.index ["survey_id"], name: "index_survey_sections_on_survey_id"
  end

  create_table "surveys", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.uuid "channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "long_description"
    t.text "required_states"
    t.text "required_counties"
    t.integer "status"
    t.datetime "response_open"
    t.datetime "response_close"
    t.boolean "require_informed_consent"
    t.text "informed_consent"
    t.text "exit_message"
    t.string "slug"
    t.integer "survey_type"
    t.index ["channel_id"], name: "index_surveys_on_channel_id"
  end

  create_table "synthesize_speech_clips", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "language_id"
    t.string "language_code"
    t.string "voice_name"
    t.integer "ssml_gender"
    t.text "encoded_text"
    t.uuid "cue_block_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cue_block_id"], name: "index_synthesize_speech_clips_on_cue_block_id"
    t.index ["language_id"], name: "index_synthesize_speech_clips_on_language_id"
  end

  create_table "text_tracks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "video_id", null: false
    t.string "label"
    t.uuid "language_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "captions"
    t.index ["language_id"], name: "index_text_tracks_on_language_id"
    t.index ["video_id"], name: "index_text_tracks_on_video_id"
  end

  create_table "uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "file_list"
    t.string "for"
    t.string "for_id"
    t.string "input_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_salt"
    t.boolean "admin"
    t.boolean "tos"
    t.datetime "tos_aggreed_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "videos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "channel_id"
    t.text "description"
    t.string "status"
    t.integer "access"
    t.integer "visibility"
    t.boolean "chroma_keyed"
    t.uuid "playlist_id"
    t.index ["channel_id"], name: "index_videos_on_channel_id"
    t.index ["playlist_id"], name: "index_videos_on_playlist_id"
  end

  create_table "virtual_spaces", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_virtual_spaces_on_event_id"
  end

  create_table "zoom_meetings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "topic"
    t.uuid "virtual_space_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "room_type"
    t.string "meeting_id"
    t.text "start_url"
    t.text "join_url"
    t.index ["virtual_space_id"], name: "index_zoom_meetings_on_virtual_space_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
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
  add_foreign_key "camp_application_cas", "camp_applications"
  add_foreign_key "camp_application_ceus", "camp_applications"
  add_foreign_key "camp_application_commitments", "camp_applications"
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
  add_foreign_key "camp_application_shifts", "camp_applications"
  add_foreign_key "camp_application_trainings", "camp_applications"
  add_foreign_key "camp_application_types", "camps"
  add_foreign_key "camp_applications", "camp_application_types"
  add_foreign_key "camp_applications", "camps"
  add_foreign_key "camp_applications", "users"
  add_foreign_key "challenge_milestones", "challenges"
  add_foreign_key "challenge_participants", "challenges"
  add_foreign_key "challenge_participants", "prices"
  add_foreign_key "challenge_participants", "users"
  add_foreign_key "channel_menu_items", "channel_menus"
  add_foreign_key "channel_menus", "channels"
  add_foreign_key "channels", "subdomains"
  add_foreign_key "counties", "state_provinces"
  add_foreign_key "cue_blocks", "text_tracks"
  add_foreign_key "donations", "challenge_participants"
  add_foreign_key "donations", "users"
  add_foreign_key "event_attendees", "events"
  add_foreign_key "event_attendees", "users"
  add_foreign_key "exercise_trackers", "challenge_participants"
  add_foreign_key "frequently_asked_questions", "challenges"
  add_foreign_key "participant_milestones", "challenge_milestones"
  add_foreign_key "participant_milestones", "challenge_participants"
  add_foreign_key "phone_numbers", "camp_application_emergencies"
  add_foreign_key "phone_numbers", "camp_application_pis"
  add_foreign_key "phone_numbers", "users"
  add_foreign_key "photos", "challenge_milestones"
  add_foreign_key "photos", "challenge_participants"
  add_foreign_key "photos", "challenges"
  add_foreign_key "photos", "exercise_trackers"
  add_foreign_key "photos", "product_image_sets"
  add_foreign_key "portfolios", "channels"
  add_foreign_key "prices", "challenges"
  add_foreign_key "product_categories", "departments"
  add_foreign_key "product_image_sets", "products"
  add_foreign_key "products", "product_categories"
  add_foreign_key "profiles", "users"
  add_foreign_key "question_options", "survey_questions"
  add_foreign_key "question_options_response_answers", "question_options"
  add_foreign_key "response_answers", "survey_questions"
  add_foreign_key "response_answers", "survey_responses"
  add_foreign_key "social_networks", "channels"
  add_foreign_key "state_provinces", "countries"
  add_foreign_key "survey_questions", "survey_sections"
  add_foreign_key "survey_responses", "surveys"
  add_foreign_key "survey_responses", "users"
  add_foreign_key "survey_sections", "surveys"
  add_foreign_key "surveys", "channels"
  add_foreign_key "synthesize_speech_clips", "cue_blocks"
  add_foreign_key "synthesize_speech_clips", "languages"
  add_foreign_key "text_tracks", "languages"
  add_foreign_key "text_tracks", "videos"
  add_foreign_key "videos", "channels"
  add_foreign_key "videos", "playlists"
  add_foreign_key "virtual_spaces", "events"
  add_foreign_key "zoom_meetings", "virtual_spaces"
end
