class ChangeVersionInTicketTables < ActiveRecord::Migration[6.1]
  def change
    rename_column :tickets, :version, :ticket_version
    add_column :foreign_tickets, :ticket_version, :integer
  end
end
