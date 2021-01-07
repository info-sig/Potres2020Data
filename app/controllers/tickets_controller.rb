class TicketsController < ApplicationController

  def index
    ::Rails.cache.fetch("Tickets#index/#{request.format.to_s}", expires_in: 3.minutes) do
      @tickets = Ticket.includes(:foreign_tickets).
        all.map{|t| render_ticket(t)}

      render :json => @tickets.to_json
    end
  end

  def show
    @ticket = render_ticket(Ticket.find(params[:id]))

    respond_to do |format|
      format.html { render :show }
      format.json { render :json => @ticket.to_json }
    end
  end


  private

  def render_ticket t
    t_attrs = t.attributes

    t_attrs[:sources] = Hash[t.foreign_tickets.map do |ft|
      ft_attrs = ft.attributes
      system_name = ft_attrs.delete('foreign_system')

      [system_name, ft_attrs]
    end]

    t_attrs
  end

end
