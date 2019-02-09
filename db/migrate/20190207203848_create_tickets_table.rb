# frozen_string_literal: true

class CreateTicketsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :url
      t.string :ticket_id
      t.string :external_id
      t.timestamps null: false
      t.string :ticket_type
      t.string :subject
      t.text :description
      t.string :priority
      t.string :status
      t.boolean :has_incidents
      t.datetime :due_at
      t.string :via
      t.integer :submitter_id
      t.integer :assignee_id
      t.integer :organization_id
    end
  end
end
