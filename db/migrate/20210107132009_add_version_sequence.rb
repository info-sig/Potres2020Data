class AddVersionSequence < ActiveRecord::Migration[6.1]
  def change
    execute 'CREATE SEQUENCE ticket_version_seq START 10000;'
  end
end
