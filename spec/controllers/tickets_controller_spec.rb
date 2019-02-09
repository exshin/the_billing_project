# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe '#GET search' do
    let(:ticket) { create :ticket, description: 'test' }
    let(:ticket_nil_description) { create :ticket, description: nil }
    let(:tag) { create :tag, tag_reference_id: ticket.id, tag_reference_type: 'Ticket' }

    context 'when searching non nil text' do
      before :each do
        ticket
        tag
        get :search, params: { searchField: 'description', searchText: 'test' }
      end

      it 'has a 200 status code' do
        expect(response.status).to eql(200)
      end

      it 'should return results with matching search terms param' do
        results = JSON.parse(response.body)['results']
        expect(results.count).to eql 1
        expect(results[0]['ticket']['id']).to eql ticket.id
      end

      it 'should return related tags' do
        results = JSON.parse(response.body)['results']
        expect(results[0]['tags'].count).to eql 1
        expect(results[0]['tags'][0]['id']).to eql tag.id
      end
    end

    context 'when searching a nil text field' do
      it 'should return even when searchText param is nil' do
        ticket_nil_description
        ticket
        get :search, params: { searchField: 'description', searchText: '' }
        results = JSON.parse(response.body)['results']

        expect(results.count).to eql 1
        expect(results[0]['ticket']['id']).to eql ticket_nil_description.id
      end
    end
  end
end
