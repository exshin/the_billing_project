# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_207_204_801) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'domain_names', force: :cascade do |t|
    t.string 'name'
    t.bigint 'organization_id'
    t.index ['organization_id'], name: 'index_domain_names_on_organization_id'
  end

  create_table 'organizations', force: :cascade do |t|
    t.string 'url'
    t.string 'external_id'
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'details'
    t.boolean 'shared_tickets'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name'
    t.string 'tag_reference_type'
    t.bigint 'tag_reference_id'
    t.index %w[tag_reference_type tag_reference_id], name: 'index_tags_on_tag_reference_type_and_tag_reference_id'
  end

  create_table 'tickets', force: :cascade do |t|
    t.string 'url'
    t.string 'ticket_id'
    t.string 'external_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'ticket_type'
    t.string 'subject'
    t.text 'description'
    t.string 'priority'
    t.string 'status'
    t.boolean 'has_incidents'
    t.datetime 'due_at'
    t.string 'via'
    t.integer 'submitter_id'
    t.integer 'assignee_id'
    t.integer 'organization_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'url'
    t.string 'external_id'
    t.string 'name'
    t.string 'alias'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'active'
    t.boolean 'verified'
    t.boolean 'shared'
    t.string 'locale'
    t.string 'timezone'
    t.datetime 'last_login_at'
    t.string 'email'
    t.string 'phone'
    t.string 'signature'
    t.boolean 'suspended'
    t.string 'role'
    t.integer 'organization_id'
  end
end
