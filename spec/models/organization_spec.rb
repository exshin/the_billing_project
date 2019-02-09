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


require 'rails_helper'

RSpec.describe Organization, type: :model do
  ## Nothing to test in this model
end
