class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets, id: :uuid do |t|
      t.string :title
      t.text :content

      t.string :status

      t.string :foreign_system
      t.string :foreign_ticket_id
      t.string :foreign_reporting_user_id

      t.string :contact_phone
      t.string :contact_address
      t.decimal :contact_latitude
      t.decimal :contact_longitude

      t.integer :version

      t.timestamps
    end
  end
end
