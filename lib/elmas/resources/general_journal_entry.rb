module Elmas
  class GeneralJournalEntry
    include Elmas::Resource

    def base_path
      "generaljournalentry/GeneralJournalEntries"
    end

    def mandatory_attributes
      [:journal, :general_journal_entry_lines]
    end
  end
end
