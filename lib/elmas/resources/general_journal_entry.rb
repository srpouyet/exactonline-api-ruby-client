module Elmas
  class GeneralJournalEntry
    include Elmas::Resource

    def base_path
      "generaljournalentry/GeneralJournalEntries"
    end

    def mandatory_attributes
      [:journal, :general_journal_entry_lines]
    end

    def other_attributes
      [:financial_period, :financial_year, :currency, :journal_description]
    end
  end
end
