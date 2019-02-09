# frozen_string_literal: true

class CreateTagsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.references :tag_reference, polymorphic: true, index: true
    end
  end
end
