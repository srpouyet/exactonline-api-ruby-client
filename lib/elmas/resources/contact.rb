module Elmas
  class Contact
    include Elmas::Resource

    def base_path
      "/crm/Contacts"
    end
  end
end
