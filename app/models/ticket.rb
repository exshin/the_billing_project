# frozen_string_literal: true

# == Schema Information
#
# Table name: tickets
#
#  id              :bigint(8)        not null, primary key
#  url             :string
#  ticket_id       :string
#  external_id     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  ticket_type     :string
#  subject         :string
#  description     :text
#  priority        :string
#  status          :string
#  has_incidents   :boolean
#  due_at          :datetime
#  via             :string
#  submitter_id    :integer
#  assignee_id     :integer
#  organization_id :integer
#


class Ticket < ApplicationRecord
  has_many :tags, as: :tag_reference

  def assignee
    return nil unless assignee_id

    User.find_by(id: assignee_id)
  end

  def submitter
    return nil unless submitter_id

    User.find_by(id: submitter_id)
  end

  def organization
    return nil unless organization_id

    Organization.find_by(id: organization_id)
  end
end
