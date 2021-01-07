class TicketsController < ApplicationController

  def index
    # ::Rails.cache.fetch("Tickets#index/#{request.format.to_s}", expires_in: 3.minutes) do
      @tickets = Ticket.includes(:foreign_tickets).all.map{|t| Ticket::Show[t]}

      render :json => @tickets.to_json
    # end
  end

  def show
    @ticket = Ticket::Show[Ticket.find(params[:id])]
    respond_to do |format|
      format.html { render :show }
      format.json { render :json => @ticket.to_json }
    end
  end

end
