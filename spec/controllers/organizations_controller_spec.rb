# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  describe '#GET search' do
    let(:organization) { create :organization, name: 'test' }
    let(:organization_nil_name) { create :organization, name: nil }
    let(:domain_name) { create :domain_name, organization_id: organization.id }
    let(:tag) { create :tag, tag_reference_id: organization.id, tag_reference_type: 'Organization' }

    context 'when searching non nil text' do
      before :each do
        organization
        domain_name
        tag
        get :search, params: { searchField: 'name', searchText: 'test' }
      end

      it 'has a 200 status code' do
        expect(response.status).to eql(200)
      end

      it 'should return results with matching search terms param' do
        results = JSON.parse(response.body)['results']
        expect(results.count).to eql 1
        expect(results[0]['organization']['id']).to eql organization.id
      end

      it 'should return related tags' do
        results = JSON.parse(response.body)['results']
        expect(results[0]['tags'].count).to eql 1
        expect(results[0]['tags'][0]['id']).to eql tag.id
      end

      it 'should return related domain names' do
        results = JSON.parse(response.body)['results']
        expect(results[0]['domain_names'].count).to eql 1
        expect(results[0]['domain_names'][0]['id']).to eql domain_name.id
      end
    end

    context 'when searching a nil text field' do
      it 'should return even when searchText param is nil' do
        organization_nil_name
        organization
        get :search, params: { searchField: 'name', searchText: '' }
        results = JSON.parse(response.body)['results']

        expect(results.count).to eql 1
        expect(results[0]['organization']['id']).to eql organization_nil_name.id
      end
    end
  end
end
