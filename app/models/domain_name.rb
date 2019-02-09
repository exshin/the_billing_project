# frozen_string_literal: true

# == Schema Information
#
# Table name: domain_names
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  organization_id :bigint(8)
#


class DomainName < ApplicationRecord
  belongs_to :organization
end
