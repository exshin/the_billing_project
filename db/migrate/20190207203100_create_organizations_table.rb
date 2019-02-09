# frozen_string_literal: true

class CreateOrganizationsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :url
      t.string :external_id
      t.string :name
      t.timestamps null: false
      t.string :details
      t.boolean :shared_tickets
    end
  end
end
