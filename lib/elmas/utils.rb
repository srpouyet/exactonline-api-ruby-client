module Elmas
  module Utils
    def self.demodulize(class_name_in_module)
      class_name_in_module.to_s.sub(/^.*::/, '')
    end

    def self.pluralize(word)
      word.to_s.sub(/([^s])$/, '\1s')
    end

    def self.modulize(class_name)
      "Elmas::#{class_name}"
    end

    def self.collection_path(class_name)
      Utils.pluralize Utils.demodulize class_name
    end

    def self.camelize(word, uppercase_first_letter = true)
      if uppercase_first_letter
        word.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
      else
        word.first + Utils.camelize(word)[1..-1]
      end
    end
  end
end
