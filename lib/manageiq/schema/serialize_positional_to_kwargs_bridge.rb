module ManageIQ
  module Schema
    module SerializePositionalToKwargsBridge
      def serialize(*args, **options)
        return super if Rails.version >= "7.1"

        # For rails 7.0.x, convert 7.1+ kwargs for coder/type into the positional argument
        # class_name_or_coder
        if options[:type]
          args << options.delete(:type)
        elsif options[:coder]
          args << options.delete(:coder)
        end

        super(*args, **options)
      end
    end
  end
end
