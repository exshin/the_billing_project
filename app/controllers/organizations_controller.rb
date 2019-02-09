# frozen_string_literal: true

class OrganizationsController < ActionController::Base
  protect_from_forgery with: :null_session

  def search
    search_terms = {}
    text = params['searchText'] == nil || params['searchText'] == '' ? nil : params['searchText']
    search_terms[params['searchField']] = text
    organizations = Organization.where(search_terms)

    results = []
    organizations.map do |organization|
      results << {
        organization: organization,
        tags: organization.tags,
        domain_names: organization.domain_names
      }
    end
    render json: { results: results }
  end
end
