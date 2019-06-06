module Concerns::FallbackDelegate
  extend ActiveSupport::Concern

  module ClassMethods

    private

    def fallback_delegate(*names, to:)
      names.each do |name|
        class_eval <<-METH
          def #{name}
            local = super
            if local.present?
              local
            elsif #{to}.present?
              #{to}.#{name}
            end
          end
        METH
      end
    end

    def soft_delegate(*names, to:)
      names.each do |name|
        class_eval <<-METH
          def #{name}
            if #{to}.present?
              #{to}.#{name}
            end
          end
        METH
      end
    end

  end

end
