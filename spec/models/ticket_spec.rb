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


require 'spec_helper'

RSpec.describe Ticket, type: :model do
  let(:user) { create :user }

  describe '#assignee' do
    context 'when assignee_id exists' do
      let(:ticket_with_assignee) { create :ticket, assignee_id: user.id }

      it 'should return the assignee as a User' do
        expect(ticket_with_assignee.assignee).to eql user
      end
    end

    context 'when assignee_id does not exist' do
      let(:ticket_without_assignee) { create :ticket, assignee_id: nil }

      it 'should return nil' do
        expect(ticket_without_assignee.assignee).to be_nil
      end
    end
  end

  describe '#submitter' do
    context 'when submitter_id exists' do
      let(:ticket_with_submitter) { create :ticket, submitter_id: user.id }

      it 'should return the submitter as a User' do
        expect(ticket_with_submitter.submitter).to eql user
      end
    end

    context 'when submitter_id does not exist' do
      let(:ticket_without_submitter) { create :ticket, submitter_id: nil }

      it 'should return nil' do
        expect(ticket_without_submitter.submitter).to be_nil
      end
    end
  end

  describe '#organization' do
    let(:organization) { create :organization }

    context 'when organization_id exists' do
      let(:ticket_with_organization) { create :ticket, organization_id: organization.id }

      it 'should return the organization as a Organization' do
        expect(ticket_with_organization.organization).to eql organization
      end
    end

    context 'when organization_id does not exist' do
      let(:ticket_without_organization) { create :ticket, organization_id: nil }

      it 'should return nil' do
        expect(ticket_without_organization.organization).to be_nil
      end
    end
  end
end
