module Spec
  module Support
    module MigrationStubs
      def self.reserved_stub
        Class.new(ActiveRecord::Base) do
          self.table_name = "reserves"
          self.inheritance_column = :_type_disabled # disable STI
          serialize :reserved, :coder => YAML
        end
      end
    end
  end
end
