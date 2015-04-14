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
      # @overload contact(id)
      #   @param id [Integer] A contact's id
      #   @return [Json] The requested user
      #   @example Return information about a contact
      #     Elmas.contact(1)
      # @format :json
      def create_contact(contact)
        post("contacts", contact.as_json)
      end
    end
  end
end
