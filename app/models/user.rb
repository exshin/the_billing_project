# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  url             :string
#  external_id     :string
#  name            :string
#  alias           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  active          :boolean
#  verified        :boolean
#  shared          :boolean
#  locale          :string
#  timezone        :string
#  last_login_at   :datetime
#  email           :string
#  phone           :string
#  signature       :string
#  suspended       :boolean
#  role            :string
#  organization_id :integer
#


class User < ApplicationRecord
  has_many :tags, as: :tag_reference

  has_many :assigned_tickets, foreign_key: 'assignee_id', class_name: 'Ticket'
  has_many :submitted_tickets, foreign_key: 'submitter_id', class_name: 'Ticket'

  def organization
    Organization.find_by(id: organization_id)
  end
end
