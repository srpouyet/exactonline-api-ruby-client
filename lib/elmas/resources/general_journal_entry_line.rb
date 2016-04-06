module Elmas
  class GeneralJournalEntryLine < Elmas::BaseEntryLine
    include Elmas::Resource

    def base_path
      "generaljournalentry/GeneralJournalEntryLines"
    end
  end
end
