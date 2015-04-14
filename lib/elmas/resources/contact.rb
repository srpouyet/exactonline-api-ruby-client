module Elmas
  class Client
    module Contact
      # Returns information about a Contact in Exact Online
      #
      # @overload contact(id)
      #   @param id [Integer] A contact's id
      #   @return [Json] The requested user
      #   @example Return information about a contact
      #     Elmas.contact(1)
      # @format :json
      def contact(id)
        get("contacts?$filter=ID eq guid'#{id}'")
      end

      # Returns information about a Contact in Exact Online
      #
      # @overload create_contact(contact)
      #   @param contact [Contact] A new contact
      #   @return [Json] The newly created user and according GUID
      #   @example Return contact with reference to contact in Exact Online
      #     Elmas.create_contact(Contact.new(first_name: "Marthyn", last_name: "Olthof", id: "87927"))
      # @format :json
      def create_contact(contact)
        post("contacts", contact.as_params)
      end
    end
  end
end
