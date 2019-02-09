# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#GET search' do
    let(:user) { create :user, name: 'test' }
    let(:user_nil_description) { create :user, name: nil }
    let(:tag) { create :tag, tag_reference_id: user.id, tag_reference_type: 'User' }

    context 'when searching non nil text' do
      before :each do
        user
        tag
        get :search, params: { searchField: 'name', searchText: 'test' }
      end

      it 'has a 200 status code' do
        expect(response.status).to eql(200)
      end

      it 'should return results with matching search terms param' do
        results = JSON.parse(response.body)['results']
        expect(results.count).to eql 1
        expect(results[0]['user']['id']).to eql user.id
      end

      it 'should return related tags' do
        results = JSON.parse(response.body)['results']
        expect(results[0]['tags'].count).to eql 1
        expect(results[0]['tags'][0]['id']).to eql tag.id
      end
    end

    context 'when searching a nil text field' do
      it 'should return even when searchText param is nil' do
        user_nil_description
        user
        get :search, params: { searchField: 'name', searchText: '' }
        results = JSON.parse(response.body)['results']

        expect(results.count).to eql 1
        expect(results[0]['user']['id']).to eql user_nil_description.id
      end
    end
  end
end
