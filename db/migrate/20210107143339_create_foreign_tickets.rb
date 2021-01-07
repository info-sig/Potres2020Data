class CreateForeignTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :foreign_tickets do |t|
      t.references :ticket, type: :uuid
      t.string :foreign_system
      t.string :foreign_ticket_id
      t.json :payload

      t.timestamps
    end
  end
end
