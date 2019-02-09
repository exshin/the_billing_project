# frozen_string_literal: true

class CreateDomainNames < ActiveRecord::Migration[5.2]
  def change
    create_table :domain_names do |t|
      t.string :name
      t.references :organization, index: true
    end
  end
end
