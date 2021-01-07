class Ticket < ApplicationRecord
  self.implicit_order_column = "created_at"

  has_paper_trail

  has_many :foreign_tickets

  def foreign_from system, opts = {}
    rv = foreign_tickets.where(foreign_system: system)

    if opts[:instantiate]
      rv = rv.first_or_initialize
      rv.attributes = {
        foreign_system: foreign_system,
        foreign_ticket_id: foreign_ticket_id,
      }

      rv
    else
      rv
    end
  end

end
