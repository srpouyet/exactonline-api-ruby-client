module Elmas
  class GeneralJournalEntry
    include Elmas::Resource

    def base_path
      "generaljournalentry/GeneralJournalEntries"
    end

    def mandatory_attributes
      [:journal_code, :general_journal_entry_lines]
    end

    def other_attributes
      [:financial_period, :financial_year, :currency, :exchange_rate, :reversal]
    end
  end
end
