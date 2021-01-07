class ForeignTicket < ApplicationRecord
  # has_paper_trail

  before_save :increment_version


  def increment_version
    self.ticket_version = self.class.sequence_nextval('ticket_version_seq')
  end

end
