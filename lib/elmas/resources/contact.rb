module Elmas
  class Contact
    include Elmas::Resource

    def url
      "/crm/Contacts"
    end

    def find
      begin
        @response = Response.create(Elmas.get("#{url}?$filter=ID eq guid'#{id}'"))
      end
    end
  end
end
