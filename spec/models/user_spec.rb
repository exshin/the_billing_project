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


require 'rails_helper'

RSpec.describe User, type: :model do
  let(:organization) { create :organization }
  let(:user) { create :user, organization_id: organization.id }

  describe '#organization' do
    it 'should return the related organization' do
      expect(user.organization).to eql organization
    end
  end
end
