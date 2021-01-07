class Date
  def self.nil_or_parse arg
    return nil if arg.blank?
    Date.parse(arg)
  end
end