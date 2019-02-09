# frozen_string_literal: true

class TicketsController < ActionController::Base
  protect_from_forgery with: :null_session

  def search
    search_terms = {}
    text = params['searchText'] == nil || params['searchText'] == '' ? nil : params['searchText']
    search_terms[params['searchField']] = text
    tickets = Ticket.where(search_terms)

    results = []
    tickets.map do |ticket|
      results << {
        ticket: ticket,
        tags: ticket.tags
      }
    end

    render json: { results: results }
  end
end
