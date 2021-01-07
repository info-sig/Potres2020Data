class Ticket
  class Show
    extend ClassFunctional

    def self.call t
      t_attrs = t.attributes

      t_attrs[:sources] = Hash[t.foreign_tickets.map do |ft|
        ft_attrs = ft.attributes
        system_name = ft_attrs.delete('foreign_system')

        ft_attrs["payload"]["values"] = DataIntegration::OpenItPotres2020.new.parse_additional_values(ft.payload["values"])
        [system_name, ft_attrs]
      end]

      t_attrs
    end
  end
end