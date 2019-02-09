# frozen_string_literal: true

class UsersController < ActionController::Base
  protect_from_forgery with: :null_session

  def search
    search_terms = {}
    text = params['searchText'] == nil || params['searchText'] == '' ? nil : params['searchText']
    search_terms[params['searchField']] = text
    users = User.where(search_terms)

    results = []
    users.map do |user|
      results << {
        user: user,
        tags: user.tags
      }
    end

    render json: { results: results }
  end
end
