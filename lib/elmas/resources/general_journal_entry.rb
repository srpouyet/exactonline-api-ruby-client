module Elmas
  class GeneralJournalEntry
    include Elmas::Resource

    def base_path
      "generaljournalentry/GeneralJournalEntries"
    end

    def mandatory_attributes
      [:code, :general_journal_entry_lines]
    end

    def other_attributes
      [:entry_id, :journal_code]
    end
  end
end
