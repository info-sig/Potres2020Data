class ActiveRecord::Base

  def self.ping
    connection.execute("select 1;")
  end

  def self.next_pk
    connection.execute("select nextval('#{table_name}_id_seq')").first["nextval"].to_i
  end

  # if record is not persisted this will eager-fetch the primary key column, if
  # it's persisted (or more accurately, primary key is already set), this will
  # echo the primary key value
  def prefetch_pk!
    primary_key = self.send "#{self.class.primary_key}"

    if primary_key.present?
      primary_key
    else
      self.send "#{self.class.primary_key}=", self.class.next_pk
    end
  end

end


class ActiveRecord::SchemaDumper

  private

  alias_method :trailer_without_backend_installer, :trailer

  def trailer(stream)
    stream.puts
    stream.puts '  Rake::Task["db:backend:install"].invoke'
    stream.puts
    trailer_without_backend_installer(stream)
  end

end
