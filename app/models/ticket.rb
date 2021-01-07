class Ticket < ApplicationRecord
  has_paper_trail
  self.implicit_order_column = "created_at"

  has_many :foreign_tickets

  before_save :increment_version

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

  def increment_version
    self.ticket_version = self.class.sequence_nextval('ticket_version_seq')
  end

end
