class Ticket < ApplicationRecord
  self.implicit_order_column = "created_at"

  has_paper_trail

end
