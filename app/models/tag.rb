# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id                 :bigint(8)        not null, primary key
#  name               :string
#  tag_reference_type :string
#  tag_reference_id   :bigint(8)
#


class Tag < ApplicationRecord
  belongs_to :tag_reference, polymorphic: true
end
