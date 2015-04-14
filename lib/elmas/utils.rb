module Elmas
  module Utils
    def self.demodulize(class_name_in_module)
      class_name_in_module.to_s.sub(/^.*::/, '')
    end

    def self.pluralize(word)
      word.to_s.sub(/([^s])$/, '\1s')
    end

    def self.collection_path(class_name)
      Utils.pluralize Utils.demodulize class_name
    end
  end
end
