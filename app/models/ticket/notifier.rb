class Ticket
  class Notifier
    include Functional
    include Backgroundable

    sidekiq_options lock: :until_and_while_executing


    def call url, ticket_id, opts = {}
      t = Ticket.find(ticket_id)
      Transporter::FaradayHttp[url, body: Ticket::Show[t].to_json]
    end
  end
end