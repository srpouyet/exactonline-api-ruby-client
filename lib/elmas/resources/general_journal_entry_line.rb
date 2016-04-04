module Elmas
  class GeneralJournalEntryLine < Elmas::BaseEntryLine
    include Elmas::Resource

    def base_path
      "generaljournalentry/GeneralJournalEntryLines"
    end

    def other_attributes
      [:account, :description]
    end
  end
end
