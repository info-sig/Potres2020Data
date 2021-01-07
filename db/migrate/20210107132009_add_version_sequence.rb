class AddVersionSequence < ActiveRecord::Migration[6.1]
  def up
    execute 'CREATE SEQUENCE IF NOT EXISTS ticket_version_seq START 10000;'
  end
end
