# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id             :bigint(8)        not null, primary key
#  url            :string
#  external_id    :string
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  details        :string
#  shared_tickets :boolean
#


class Organization < ApplicationRecord
  has_many :tags, as: :tag_reference
  has_many :domain_names
  has_many :users
  has_many :tickets
end
