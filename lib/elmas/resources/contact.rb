module Elmas
  class Contact
    # A contact needs a First and Last name and a reference to an account
    include Elmas::Resource

    def base_path
      "/crm/Contacts"
    end

    def mandatory_attributes
      [:first_name, :last_name, :account]
    end
  end
end
