# == Schema Information
#
# Table name: domain_names
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  organization_id :bigint(8)
#

require 'rails_helper'

RSpec.describe DomainName, type: :model do
  ## Nothing to test in this model
end
