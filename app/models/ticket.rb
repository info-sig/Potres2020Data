class Ticket < ApplicationRecord
  # has_paper_trail
  self.implicit_order_column = "created_at"

  SUBSCRIBERS = (ENV['TICKET_SUBSCRIBERS'] || '').split(/, */)


  has_many :foreign_tickets

  before_save :increment_version, if: :really_changed?
  before_save :detect_if_should_notify, if: :really_changed?
  after_save :notify_subscribers

  def self.version_seq_curval
    ActiveRecord::Base.sequence_curval 'ticket_version_seq'
  end

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

  def really_changed
    changed - ['updated_at']
  end

  def really_changed?
    really_changed.present?
  end


  private

  def increment_version
    self.ticket_version = self.class.sequence_nextval('ticket_version_seq')
  end

  def notify_subscribers
    return true unless @__should_notify

    SUBSCRIBERS.each do |url|
      Ticket::Notifier.perform_in 15.seconds, url, self.id
    end
    true
  end

  def detect_if_should_notify
    @__should_notify = really_changed?
  end

end
