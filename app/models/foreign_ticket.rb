class ForeignTicket < ApplicationRecord
  # has_paper_trail

  before_save :increment_version, if: :really_changed?


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

end
